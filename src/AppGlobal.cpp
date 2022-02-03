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

QObject *AppGlobal::singletonProvider(QQmlEngine *engine, QJSEngine *script) {
  Q_UNUSED(engine);
  Q_UNUSED(script);

  return AppGlobal::instance();
}

void AppGlobal::registerType() {
  qmlRegisterSingletonType<AppGlobal>("UniversalLauncher", 1, 0, "AppGlobal",
                                      AppGlobal::singletonProvider);

  FolderSystem::registerType();
}

AppGlobal::AppGlobal() : QObject() {
  m_folder_system = std::make_unique<FolderSystem>();
  m_router = std::make_unique<Router>();
  m_themes = std::make_unique<Themes>();
  m_settings = std::make_unique<SettingsSystem>(m_folder_system.get());
}

AppGlobal::~AppGlobal() {}

FolderSystem *AppGlobal::folderSystem() const { return m_folder_system.get(); }

Router *AppGlobal::router() const { return m_router.get(); }

Themes *AppGlobal::themes() const { return m_themes.get(); }

SettingsSystem *AppGlobal::settings() const { return m_settings.get(); }
