#pragma once

#include <QJsonDocument>

struct MinecraftSkin {
  QString id;
  QString state;
  QUrl url;
  QString variant;
  QString alias;
};

struct MinecraftCapes {};

class MinecraftProfile : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString username READ username CONSTANT)
  Q_PROPERTY(QUrl currentSkin READ currentSkin CONSTANT)
  Q_PROPERTY(QUrl avatar READ avatar CONSTANT)

public:
  MinecraftProfile();
  ~MinecraftProfile();

  static MinecraftProfile *fromJson(QJsonDocument &doc);

  QString id() const { return m_id; }

  QString username() const { return m_username; }

  QUrl currentSkin() const;

  QUrl avatar() const { return m_avatar_data; }

public slots:
  void fetchAvatar();

private:
  QString m_id;
  QString m_username;
  QVector<MinecraftSkin> m_skins;
  QVector<MinecraftCapes> m_capes;
  QUrl m_avatar_data;
};
