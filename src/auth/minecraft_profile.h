#pragma once

#include <qt_mcauth/qt_mcauth.h>

#include <QJsonDocument>
#include <nlohmann/json.hpp>

class MinecraftProfile : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString id READ id NOTIFY accountUpdated)
  Q_PROPERTY(QString username READ username NOTIFY accountUpdated)
  Q_PROPERTY(QUrl currentSkin READ currentSkin NOTIFY accountUpdated)
  Q_PROPERTY(QUrl avatar READ avatar NOTIFY accountUpdated)

public:
  MinecraftProfile();
  ~MinecraftProfile();

  static MinecraftProfile *fromJson(QJsonDocument &obj);
  static MinecraftProfile *fromJson(nlohmann::json &obj);
  static MinecraftProfile *fromMCAuth(MCAccount &account);

  QString id() const { return m_id; }

  QString username() const { return m_username; }

  QUrl currentSkin() const;

  QUrl avatar() const { return m_avatar; }

  QString accessToken() const { return m_access_token; }
  QString refreshToken() const { return m_refresh_token; }

  void setTokens(const QString &accessToken, const QString &refreshToken);
  void setAvatar(const QString &avatar);

signals:
  void accountUpdated();
public slots:
  void fetchAvatar();

private:
  QString m_id;
  QString m_username;
  QVector<MinecraftSkin> m_skins;
  QVector<MinecraftCapes> m_capes;
  QUrl m_avatar;
  QString m_mc_access_token;

  QString m_access_token;
  QString m_refresh_token;
};
