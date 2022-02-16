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

MinecraftProfile *MinecraftProfile::fromJson(nlohmann::json &obj) {
  MinecraftProfile *profile = new MinecraftProfile();

  profile->m_id = QString::fromStdString(obj["id"].get<std::string>());
  profile->m_username = QString::fromStdString(obj["name"].get<std::string>());

  for (const auto &value : obj["skins"].array()) {
    MinecraftSkin skin{};
    skin.id = QString::fromStdString(value["id"].get<std::string>());
    skin.state = QString::fromStdString(value["state"].get<std::string>());
    skin.url = QString::fromStdString(value["url"].get<std::string>());
    skin.variant = QString::fromStdString(value["variant"].get<std::string>());
    skin.alias = QString::fromStdString(value["alias"].get<std::string>());

    profile->m_skins.push_back(skin);
  }

  return profile;
}

MinecraftProfile *MinecraftProfile::fromMCAuth(MCAccount &account) {
  MinecraftProfile *profile = new MinecraftProfile();
  profile->m_id = account.id;
  profile->m_username = account.username;

  profile->m_skins = account.skins;
  profile->m_capes = account.capes;
  profile->m_mc_access_token = account.accessToken;

  qDebug() << account.currentSkin.has_value();

  if (account.currentSkin.has_value()) {
    auto avatar = account.currentSkin.value();
    avatar = avatar.copy(8, 8, 8, 8);

    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    avatar.save(&buffer, "PNG");

    profile->m_avatar =
        QUrl{"data:image/png;base64," + buffer.data().toBase64()};
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

  m_avatar = QUrl{"data:image/png;base64," + buffer.data().toBase64()};
}

void MinecraftProfile::setTokens(const QString &accessToken,
                                 const QString &refreshToken) {
  m_access_token = accessToken;
  m_refresh_token = refreshToken;
}

void MinecraftProfile::setAvatar(const QString &avatar) { m_avatar = avatar; }
