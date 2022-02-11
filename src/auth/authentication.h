#pragma once

#include "minecraft_profile.h"
#include <QOAuth2AuthorizationCodeFlow>
#include <QObject>
#include <QtNetwork>
#include <QtNetworkAuth>
#include <memory>

struct MCAccountInfo {
  QString username;
  QString accessToken;
  QString tokenType;
  int expiresIn;
};

class Authentication : public QObject {
  Q_OBJECT
public:
  Authentication(QObject *parent = nullptr);
  ~Authentication();

  static void registerType();

public slots:
  void startProcess();
  void stop();

signals:
  void authFinished();
  void authFailed();

private:
  void processAuthentication();
  bool authenticateXBL(QString &userHash, QString &xblToken);
  bool authenticateXSTS(const QString &userHash, const QString &xblToken,
                        QString &xstsToken);
  bool authenticateMinecraft(const QString &userHash, const QString &xstsToken,
                             MCAccountInfo &account);
  bool fetchMinecraftProfile(MCAccountInfo &account,
                             MinecraftProfile **profile);

  std::unique_ptr<QOAuth2AuthorizationCodeFlow> m_oauth2;
  std::unique_ptr<QOAuthHttpServerReplyHandler> m_replyHandler;
  std::unique_ptr<QNetworkAccessManager> m_nam;

  QString m_clientID;
  QUrl m_authorizeUrl;
};
