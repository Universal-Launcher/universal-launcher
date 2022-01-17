#include "accountdata.h"

#include <QJsonObject>
#include <QJsonArray>
#include <QImage>

#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QPixmap>
#include <QtCore>

QPixmap download_from(const QString& url) {
    QNetworkAccessManager nam;
    QNetworkReply *reply = nam.get(QNetworkRequest(url));

    while(!reply->isFinished()) {
        qApp->processEvents();
    }

    QPixmap pm;
    pm.loadFromData(reply->readAll());

    reply->deleteLater();

    return pm;
}

MinecraftProfile::MinecraftProfile(QJsonDocument obj) {
    this->id = obj["id"].toString();
    this->name = obj["name"].toString();

    foreach (const QJsonValue &value, obj["skins"].toArray()) {
        MinecraftSkins skin{};
        skin.id = value["id"].toString();
        skin.state = value["state"].toString();
        skin.url = value["url"].toString();
        skin.variant = value["variant"].toString();
        skin.alias = value["alias"].toString();

        skins.emplaceBack(skin);
    }
}

void MinecraftProfile::fetchAvatar() {
    qDebug() << "Try to get the player avatar";
    // Download the skins image and save the avatar
    QPixmap avatar = download_from(this->currentSkin().url());
    avatar = avatar.copy(8, 8, 8, 8);

    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    avatar.save(&buffer, "PNG");

    this->avatar_data = QUrl("data:image/png;base64," + buffer.data().toBase64());
}

QUrl MinecraftProfile::currentSkin() const {
    QUrl url{""};
    if (skins.size() > 0) {
        MinecraftSkins* skin = nullptr;
        foreach(auto s, skins) {
            if (s.state == "ACTIVE") {
                skin = &s;
            }

        }

        if (skin) {
            url.setUrl(skin->url);
        } else {
            url.setUrl(skins.at(0).url);
        }
    }

    return url;
}
