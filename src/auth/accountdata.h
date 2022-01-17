#pragma once

#include <QString>
#include <QMap>
#include <QJsonDocument>

struct MinecraftSkins {
    QString id;
    QString state;
    QString url;
    QString variant;
    QString alias;
};

struct MinecraftCapes {

};

class MinecraftProfile : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString username READ username CONSTANT)
    Q_PROPERTY(QUrl currentSkin READ currentSkin CONSTANT)
    Q_PROPERTY(QUrl avatar READ avatar CONSTANT)
private:
    QString id;
    QString name;
    QVector<MinecraftSkins> skins;
    QVector<MinecraftCapes> capes;
    QUrl avatar_data;

public:
    MinecraftProfile(QJsonDocument obj);
    ~MinecraftProfile() = default;

    void fetchAvatar();

private:
    QString username() const {
        return name;
    }

    QUrl currentSkin() const;

    QUrl avatar() const {
        return avatar_data;
    }
};

struct MCAccountInfo {
    QString username;
    QString accessToken;
    QString tokenType;
    int expiresIn;
};
