#pragma once

#include <QSettings>
#include <QOAuth2AuthorizationCodeFlow>
#include "auth/accountdata.h"

class Settings
{
public:
    static Settings* instance();

    void saveProfile(QOAuth2AuthorizationCodeFlow* oauth2, MCAccountInfo* account, MinecraftProfile* profile);
    void loadProfile(QOAuth2AuthorizationCodeFlow* oauth2);

private:
    static Settings* m_instance;

    Settings();

    QSettings* m_settings;
};
