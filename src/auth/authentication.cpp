#include "authentication.h"

#include <QtGui>
#include <QUrlQuery>
#include <QtNetworkAuth>
#include "../settings.h"

Authentication* Authentication::m_instance = nullptr;

Authentication* Authentication::instance() {
    if (!m_instance) {
        m_instance = new Authentication();
    }
    return m_instance;
}

Authentication::Authentication(QObject* parent) : QObject(parent), m_isAuthenticated(false)
{
    QString clientId = "b3980a32-fd8e-4bb5-a469-58e4bff070a0";

    m_oauth2.setClientIdentifier(clientId);

    auto replyHandler = new QOAuthHttpServerReplyHandler(25560, this);
    m_oauth2.setReplyHandler(replyHandler);

    QUrl authorizeUrl = QUrl{"https://login.live.com/oauth20_authorize.srf"};
    QUrlQuery queries{};
    queries.addQueryItem("client_id", clientId);
    queries.addQueryItem("response_type", "code");
    authorizeUrl.setQuery(queries);
    m_oauth2.setScope("XboxLive.signin offline_access");

    m_oauth2.setAuthorizationUrl(authorizeUrl);
    m_oauth2.setAccessTokenUrl(QUrl("https://login.live.com/oauth20_token.srf"));

    m_oauth2.setModifyParametersFunction([&](QAbstractOAuth::Stage stage, QMultiMap<QString, QVariant> *parameters) {
        parameters->replace("redirect_uri", "http://localhost:25560");
    });

    connect(&m_oauth2, &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser, &QDesktopServices::openUrl);
    connect(&m_oauth2, &QOAuth2AuthorizationCodeFlow::statusChanged, [=](QAbstractOAuth::Status status) {
        if (status == QAbstractOAuth::Status::Granted) {
            processAuthentication();
        } else {
            setAuthenticated(false);
        }
    });
}

void Authentication::setCredentials(const QString& clientId, const QString& clientSecret) {
    m_oauth2.setClientIdentifier(clientId);
    m_oauth2.setClientIdentifierSharedKey(clientSecret);
}

void Authentication::authorize() {
    m_oauth2.grant();
}

void Authentication::processAuthentication() {
    if (!m_nam) {
        m_nam = std::make_unique<QNetworkAccessManager>();
        m_nam->setAutoDeleteReplies(true);
    }
    QString xui_UserHash;
    QString xblToken;
    QString xstsToken;
    MCAccountInfo account{};
    MinecraftProfile* profile = nullptr;

    if (!authenticateXBL(&xui_UserHash, &xblToken)) {
        setAuthenticated(false);
        return;
    }

    if(!authenticateXSTS(xblToken, xui_UserHash, &xstsToken)) {
        setAuthenticated(false);
        return;
    }

    if (!authenticateMinecraft(xui_UserHash, xstsToken, &account)) {
        setAuthenticated(false);
        return;
    }

    if (!fetchMinecraftProfile(&account, &profile)) {
        setAuthenticated(false);
        return;
    }

    this->m_profile = std::unique_ptr<MinecraftProfile>(profile);
    this->m_profile->fetchAvatar();

    auto settings = Settings::instance();

    settings->saveProfile(&m_oauth2, &account, this->m_profile.get());

    setAuthenticated(true);
}

bool Authentication::authenticateXBL(QString* xui_userHash, QString* xblToken) {
    qDebug() << "Authenticating to XBoxLive";

    QNetworkRequest http(QUrl("https://user.auth.xboxlive.com/user/authenticate"));
    http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QString accessToken = m_oauth2.token();

    QJsonObject obj{
        {"Properties", QJsonObject{
                {"AuthMethod", "RPS"},
                {"SiteName", "user.auth.xboxlive.com"},
                {"RpsTicket", "d="+accessToken}
            }
        },
        {"RelyingParty", "http://auth.xboxlive.com"},
        {"TokenType", "JWT"}
    };
    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();

    QNetworkReply *reply = m_nam->post(http, data);

    while(!reply->isFinished()) {
        qApp->processEvents();
    }

    if (reply->error() == QNetworkReply::NoError) {
        QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

        QJsonArray arr = doc["DisplayClaims"]["xui"].toArray();

        if (arr.size() > 0) {
            *xui_userHash = arr.at(0)["uhs"].toString();
            *xblToken = doc["Token"].toString();

            reply->deleteLater();
            return true;
        } else {
            qDebug() << "No claims found, user not authenticated";
        }
    } else {
        QString err = reply->errorString();
        qDebug() << err;
    }

    reply->deleteLater();
    return false;
}

bool Authentication::authenticateXSTS(QString token, QString xui_userHash, QString* xstsToken) {
    qDebug() << "Authenticating to XSTS";

    QNetworkRequest http(QUrl("https://xsts.auth.xboxlive.com/xsts/authorize"));
    http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject obj{
        {"Properties", QJsonObject{
                {"SandboxId", "RETAIL"},
                {"UserTokens", QJsonArray{token}},
            }},
        {"RelyingParty", "rp://api.minecraftservices.com/"},
        {"TokenType", "JWT"}
    };
    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();

    QNetworkReply *reply = m_nam->post(http, data);


    while(!reply->isFinished()) {
        qApp->processEvents();
    }

    if (reply->error() == QNetworkReply::NoError) {
        QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

        if (doc["DisplayClaims"]["xui"][0]["uhs"].toString() == xui_userHash) {
            *xstsToken = doc["Token"].toString();

            reply->deleteLater();

            return true;
        } else {
            qDebug() << "XUI token doesn't match";
        }
    } else {
        QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
        if (statusCode.isValid() && statusCode.toInt() == 401) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            qDebug() << "Account authentication failed, error code: " << doc["XErr"];
        } else {
            QString err = reply->errorString();
            qDebug() << err;
        }
    }

    reply->deleteLater();
    return false;
}

bool Authentication::authenticateMinecraft(QString userHash, QString xstsToken, MCAccountInfo* account) {
    qDebug() << "Authenticating to Minecraft";

    QNetworkRequest http(QUrl("https://api.minecraftservices.com/authentication/login_with_xbox"));
    http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QString token = QString("XBL3.0 x=%1;%2").arg(userHash, xstsToken);
    QJsonObject obj{
        {"identityToken", token}
    };

    QJsonDocument doc(obj);
    QByteArray data = doc.toJson();

    QNetworkReply *reply = m_nam->post(http, data);

    while(!reply->isFinished()) {
        qApp->processEvents();
    }


    if (reply->error() == QNetworkReply::NoError) {
        QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

        account->username = doc["username"].toString();
        account->accessToken = doc["access_token"].toString();
        account->tokenType = doc["token_type"].toString();
        account->expiresIn = doc["expires_in"].toInt();

        reply->deleteLater();

        return true;
    } else {
        QString err = reply->errorString();
        qDebug() << err;
    }

    reply->deleteLater();
    return false;
}

bool Authentication::fetchMinecraftProfile(MCAccountInfo* account, MinecraftProfile** profile) {
    qDebug() << "Fetching Minecraft account";

    QNetworkRequest http(QUrl("https://api.minecraftservices.com/minecraft/profile"));
    http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    http.setRawHeader(QByteArray("Authorization"), "Bearer " + account->accessToken.toUtf8());

    QNetworkReply *reply = m_nam->get(http);

    while(!reply->isFinished()) {
        qApp->processEvents();
    }

    if (reply->error() == QNetworkReply::NoError) {
        QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

        qDebug() << "Minecraft account authenticated !!!";
        *profile = new MinecraftProfile(doc);

        reply->deleteLater();

        return true;
    } else {
        QString err = reply->errorString();
        qDebug() << err;
    }
    reply->deleteLater();

    return false;
}

MinecraftProfile* Authentication::getMinecraftProfile() {
    return this->m_profile.get();
}

void Authentication::refresh() {
    auto settings = Settings::instance();
    settings->loadProfile(&m_oauth2);

    if (m_oauth2.token().size() > 0 && m_oauth2.refreshToken().size() > 0) {
        this->m_is_refreshing = true;
        m_oauth2.refreshAccessToken();
    } else {
        emit refreshFinished();
    }
}
