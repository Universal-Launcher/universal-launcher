#include "AppGlobal.h"

#include <QQmlContext>
#include <QQmlEngine>

AppGlobal *AppGlobal::s_instance = nullptr;

AppGlobal *AppGlobal::instance() {
  if (!s_instance) {
    s_instance = new AppGlobal();
  }

  return s_instance;
}

void AppGlobal::destroy() { delete s_instance; }

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
    : QObject(), m_folder_system(std::make_unique<FolderSystem>(this)),
      m_router(std::make_unique<Router>(this)),
      m_themes(std::make_unique<Themes>(this)),
      m_settings(
          std::make_unique<SettingsSystem>(m_folder_system.get(), this)) {}

AppGlobal::~AppGlobal() {}

FolderSystem *AppGlobal::folderSystem() { return m_folder_system.get(); }

Router *AppGlobal::router() { return m_router.get(); }

Themes *AppGlobal::themes() { return m_themes.get(); }

SettingsSystem *AppGlobal::settings() { return m_settings.get(); }
