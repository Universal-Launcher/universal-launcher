#include "minecraft_profile.h"

#include <QImage>
#include <QJsonArray>
#include <QJsonObject>
#include <QPixmap>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QPixmap>
#include <QtCore>

QPixmap download_from(const QString &url) {
  QNetworkAccessManager nam;
  QNetworkReply *reply = nam.get(QNetworkRequest(url));

  while (!reply->isFinished()) {
    qApp->processEvents();
  }

  QPixmap pm;
  pm.loadFromData(reply->readAll());

  reply->deleteLater();

  return pm;
}

MinecraftProfile::MinecraftProfile() {}

MinecraftProfile::~MinecraftProfile() {}

MinecraftProfile *MinecraftProfile::fromJson(QJsonDocument &obj) {
  MinecraftProfile *profile = new MinecraftProfile();

  profile->m_id = obj["id"].toString();
  profile->m_username = obj["name"].toString();

  for (const QJsonValue &value : obj["skins"].toArray()) {
    MinecraftSkin skin{};
    skin.id = value["id"].toString();
    skin.state = value["state"].toString();
    skin.url = value["url"].toString();
    skin.variant = value["variant"].toString();
    skin.alias = value["alias"].toString();

    profile->m_skins.push_back(skin);
  }

  return profile;
}

QUrl MinecraftProfile::currentSkin() const {
  QUrl url;

  if (m_skins.size() > 0) {
    const MinecraftSkin *skin = nullptr;

    for (const MinecraftSkin &s : m_skins) {
      if (s.state == "ACTIVE") {
        skin = &s;
      }
    }

    url = skin ? skin->url : m_skins.first().url;
  }

  return url;
}

void MinecraftProfile::fetchAvatar() {
  qDebug() << "Try to get the player avatar";

  // Download the skins image and save the avatar
  QPixmap avatar = download_from(currentSkin().url());
  avatar = avatar.copy(8, 8, 8, 8);

  QBuffer buffer;
  buffer.open(QIODevice::WriteOnly);
  avatar.save(&buffer, "PNG");

  m_avatar_data = QUrl{"data:image/png;base64," + buffer.data().toBase64()};
}
