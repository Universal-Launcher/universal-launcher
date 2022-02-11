#include "authentication.h"

#include <QDesktopServices>
#include <QJsonObject>
#include <QQmlEngine>
#include <QUrlQuery>
#include <QtNetworkAuth>

#include "accounts_manager.h"
#include <secrets.h>

void Authentication::registerType() {
  qmlRegisterType<Authentication>("UniversalLauncher", 1, 0, "Authentication");
}

Authentication::Authentication(QObject *parent) : QObject(parent) {
  if (!Secrets::hasMSAClientID()) {
    printf("MSA client ID is required to build the launcher\n");
    return;
  }

  m_clientID = Secrets::getMSAClientID();
  m_authorizeUrl = QUrl{"https://login.live.com/oauth20_authorize.srf"};
  QUrlQuery queries{};
  queries.addQueryItem("client_id", m_clientID);
  queries.addQueryItem("response_type", "code");
  m_authorizeUrl.setQuery(queries);
}

Authentication::~Authentication() {}

void Authentication::startProcess() {
  m_oauth2 = std::make_unique<QOAuth2AuthorizationCodeFlow>();
  m_oauth2->setClientIdentifier(m_clientID);

  m_replyHandler = std::make_unique<QOAuthHttpServerReplyHandler>(25560, this);
  m_oauth2->setReplyHandler(m_replyHandler.get());

  m_oauth2->setScope("XboxLive.signin offline_access");

  m_oauth2->setAuthorizationUrl(m_authorizeUrl);
  m_oauth2->setAccessTokenUrl(QUrl{"https://login.live.com/oauth20_token.srf"});

  m_oauth2->setModifyParametersFunction(
      [=](QAbstractOAuth::Stage stage, QVariantMap *parameters) {
        Q_UNUSED(stage);
        if (parameters->contains("redirect_uri")) {
          parameters->remove("redirect_uri");
        }
        parameters->insert("redirect_uri", "http://localhost:25560");
      });

  connect(m_oauth2.get(), &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser,
          &QDesktopServices::openUrl);
  connect(m_oauth2.get(), &QOAuth2AuthorizationCodeFlow::statusChanged,
          [&](QAbstractOAuth::Status status) {
            if (status == QAbstractOAuth::Status::Granted) {
              processAuthentication();
            }
          });

  m_oauth2->grant();
}

void Authentication::stop() {
  m_oauth2.reset();
  m_replyHandler.reset();
}

void Authentication::processAuthentication() {
  if (!m_nam) {
    m_nam = std::make_unique<QNetworkAccessManager>(this);
    m_nam->setAutoDeleteReplies(true);
  }

  QString xui_UserHash;
  QString xblToken;
  QString xstsToken;
  MCAccountInfo account{};
  MinecraftProfile *profile = nullptr;

  if (!m_oauth2 || !authenticateXBL(xui_UserHash, xblToken)) {
    emit authFailed();
    return;
  }

  if (!m_oauth2 || !authenticateXSTS(xui_UserHash, xblToken, xstsToken)) {
    emit authFailed();
    return;
  }

  if (!m_oauth2 || !authenticateMinecraft(xui_UserHash, xstsToken, account)) {
    emit authFailed();
    return;
  }

  if (!m_oauth2 || !fetchMinecraftProfile(account, &profile)) {
    emit authFailed();
    return;
  }

  profile->fetchAvatar();

  AccountsManager::instance()->addAccount(profile);

  emit authFinished();
}

bool Authentication::authenticateXBL(QString &xui_userHash, QString &xblToken) {
  qDebug() << "Authenticating to XBoxLive";

  QNetworkRequest http{
      QUrl{"https://user.auth.xboxlive.com/user/authenticate"}};
  http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  QString accessToken = m_oauth2->token();

  QJsonObject obj{
      {"Properties", QJsonObject{{"AuthMethod", "RPS"},
                                 {"SiteName", "user.auth.xboxlive.com"},
                                 {"RpsTicket", "d=" + accessToken}}},
      {"RelyingParty", "http://auth.xboxlive.com"},
      {"TokenType", "JWT"}};
  QJsonDocument doc{obj};

  auto reply = m_nam->post(http, doc.toJson());

  while (!reply->isFinished()) {
    qApp->processEvents();
  }

  if (reply->error() == QNetworkReply::NoError) {
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    QJsonArray arr = doc["DisplayClaims"]["xui"].toArray();

    if (arr.size() > 0) {
      xui_userHash = arr.at(0)["uhs"].toString();
      xblToken = doc["Token"].toString();

      reply->deleteLater();
      return true;
    } else {
      qDebug() << "No claims found, user not authenticated";
    }
  } else {
    qDebug() << reply->errorString();
  }

  reply->deleteLater();
  return false;
}

bool Authentication::authenticateXSTS(const QString &xui_userHash,
                                      const QString &xblToken,
                                      QString &xstsToken) {
  qDebug() << "Authenticating to XSTS";

  QNetworkRequest http{QUrl{"https://xsts.auth.xboxlive.com/xsts/authorize"}};
  http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  QJsonObject obj{{"Properties",
                   QJsonObject{
                       {"SandboxId", "RETAIL"},
                       {"UserTokens", QJsonArray{xblToken}},
                   }},
                  {"RelyingParty", "rp://api.minecraftservices.com/"},
                  {"TokenType", "JWT"}};
  QJsonDocument doc{obj};

  auto reply = m_nam->post(http, doc.toJson());

  while (!reply->isFinished()) {
    qApp->processEvents();
  }

  if (reply->error() == QNetworkReply::NoError) {
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

    if (doc["DisplayClaims"]["xui"][0]["uhs"].toString() == xui_userHash) {
      xstsToken = doc["Token"].toString();
      reply->deleteLater();

      return true;
    } else {
      qDebug() << "XUI token doesn't match";
    }
  } else {
    QVariant statusCode =
        reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    if (statusCode.isValid() && statusCode.toInt() == 401) {
      auto doc = QJsonDocument::fromJson(reply->readAll());
      qDebug() << "Account authentication failed, error code: " << doc["XErr"];
    } else {
      qDebug() << reply->errorString();
    }
  }

  reply->deleteLater();
  return false;
}

bool Authentication::authenticateMinecraft(const QString &userHash,
                                           const QString &xstsToken,
                                           MCAccountInfo &account) {
  qDebug() << "Authenticating to Minecraft";
  QNetworkRequest http{
      QUrl{"https://api.minecraftservices.com/authentication/login_with_xbox"}};
  http.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  QString token = QString{"XBL3.0 x=%1;%2"}.arg(userHash, xstsToken);
  QJsonObject obj{{"identityToken", token}};
  QJsonDocument doc{obj};

  auto reply = m_nam->post(http, doc.toJson());

  while (!reply->isFinished()) {
    qApp->processEvents();
  }

  if (reply->error() == QNetworkReply::NoError) {
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

    account.username = doc["username"].toString();
    account.accessToken = doc["access_token"].toString();
    account.tokenType = doc["token_type"].toString();
    account.expiresIn = doc["expires_in"].toInt();

    reply->deleteLater();

    return true;
  } else {
    QString err = reply->errorString();
    qDebug() << err;
  }

  reply->deleteLater();
  return false;
}

bool Authentication::fetchMinecraftProfile(MCAccountInfo &account,
                                           MinecraftProfile **profile) {
  qDebug() << "Fetching Minecraft account";

  QNetworkRequest http{
      QUrl{"https://api.minecraftservices.com/minecraft/profile"}};
  http.setHeader(QNetworkRequest::ContentTypeHeader, "applicaiton/json");
  http.setRawHeader("Authorization", "Bearer " + account.accessToken.toUtf8());

  auto reply = m_nam->get(http);

  while (!reply->isFinished()) {
    qApp->processEvents();
  }
  if (reply->error() == QNetworkReply::NoError) {
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

    qDebug() << "Minecraft account authenticated !!!";
    *profile = MinecraftProfile::fromJson(doc);

    reply->deleteLater();

    return true;
  } else {
    QString err = reply->errorString();
    qDebug() << err;
  }
  reply->deleteLater();

  return false;
}
