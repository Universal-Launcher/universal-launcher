#pragma once

#include <QUrl>
#include <QString>
#include <optional>
#include <memory>

#include <QtCore>
#include <QtNetwork>
#include <QtQml/qqml.h>
#include <QOAuth2AuthorizationCodeFlow>


#include "accountdata.h"

class Authentication : public QObject {
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(bool isAuthenticated READ isAuthenticated WRITE setAuthenticated NOTIFY authChanged)

	public:
        static Authentication* instance();

        void setAuthenticated(bool isAuthenticated) {
            if (m_isAuthenticated != isAuthenticated) {
                m_isAuthenticated = isAuthenticated;
                emit authChanged(isAuthenticated);
            }

            this->m_is_refreshing = false;
            emit refreshFinished();
        }

        bool isAuthenticated() const {
            return m_isAuthenticated;
        }

public slots:
        void setCredentials(const QString& clientId, const QString& clientSecret);
        void authorize();
        void refresh();
        MinecraftProfile* getMinecraftProfile();

signals:
        void authChanged(bool authenticated);
        void refreshFinished();

private:
        static Authentication* m_instance;
        Authentication(QObject* parent = nullptr);

        QOAuth2AuthorizationCodeFlow m_oauth2;
        bool m_isAuthenticated;
        QString m_authorization_code;

        bool m_is_refreshing = false;

        void processAuthentication();

        bool authenticateXBL(QString* xui_userHash, QString* xblToken);
        bool authenticateXSTS(QString token, QString xui_userHash, QString* xstsToken);
        bool authenticateMinecraft(QString userHash, QString xstsToken, MCAccountInfo* account);
        bool fetchMinecraftProfile(MCAccountInfo* account, MinecraftProfile** profile);

        std::shared_ptr<MinecraftProfile> m_profile;

        std::unique_ptr<QNetworkAccessManager> m_nam;
};
