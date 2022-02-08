#include "AppGlobal.h"

#include <QJsonArray>
#include <QQmlContext>
#include <QQmlEngine>

AppGlobal *AppGlobal::s_instance = nullptr;

AppGlobal *AppGlobal::instance() {
  if (!s_instance) {
    s_instance = new AppGlobal();
  }

  return s_instance;
}

void AppGlobal::registerType() {
  qmlRegisterSingletonType<AppGlobal>(
      "UniversalLauncher", 1, 0, "AppGlobal",
      [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);
        return AppGlobal::instance();
      });

  FolderSystem::registerType();
  Router::registerType();
  Themes::registerType();
}

AppGlobal::AppGlobal()
    : QObject(), m_folder_system(new FolderSystem(this)),
      m_router(new Router(this)), m_themes(new Themes(this)),
      m_settings(new SettingsSystem(m_folder_system.data(), this)),
      m_translator(new Translator(this)) {}

AppGlobal::~AppGlobal() {}

FolderSystem *AppGlobal::folderSystem() { return m_folder_system.data(); }

Router *AppGlobal::router() { return m_router.data(); }

Themes *AppGlobal::themes() { return m_themes.data(); }

SettingsSystem *AppGlobal::settings() { return m_settings.data(); }

Translator *AppGlobal::translator() { return m_translator.data(); }

void AppGlobal::finishSetup() {
  auto settings = m_settings->get();
  settings->emplace("configured", true);
  settings->emplace("language", m_translator->currentLanguage().toStdString());
  settings->emplace("theme", m_themes->currentThemeName().toStdString());
  settings->emplace("java", nlohmann::json::array());
  m_settings->save();
  emit setupFinished();
}
