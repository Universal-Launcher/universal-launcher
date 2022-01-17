#include "settings.h"

Settings* Settings::m_instance = nullptr;

Settings* Settings::instance() {
    if (m_instance == nullptr) {
        m_instance = new Settings();
    }
    return m_instance;
}

Settings::Settings()
{
    this->m_settings = new QSettings("Universal-Launcher");
}

void Settings::saveProfile(QOAuth2AuthorizationCodeFlow* oauth2, MCAccountInfo* account, MinecraftProfile *profile) {
    m_settings->setValue("account/ms_accessToken", oauth2->token());
    m_settings->setValue("account/ms_refreshToken", oauth2->refreshToken());
    m_settings->setValue("player/avatar", profile->avatar());

    m_settings->sync();
}

void Settings::loadProfile(QOAuth2AuthorizationCodeFlow* oauth2) {
    m_settings->sync();

    QString msAccessToken = m_settings->value("account/ms_accessToken").toString();
    QString msRefreshToken = m_settings->value("account/ms_refreshToken").toString();

    if (msAccessToken.size() > 0 && msRefreshToken.size() > 0) {
        oauth2->setToken(msAccessToken);
        oauth2->setRefreshToken(msRefreshToken);
    }
}
