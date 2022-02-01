#include "AppGlobal.h"

#include <QQmlContext>
#include <QQmlEngine>

QObject *AppGlobal::singletonProvider(QQmlEngine *engine, QJSEngine *script) {
  Q_UNUSED(engine);
  Q_UNUSED(script);

  AppGlobal *app = new AppGlobal();
  return app;
}

void AppGlobal::registerType() {
  qmlRegisterSingletonType<AppGlobal>("UniversalLauncher", 1, 0, "AppGlobal",
                                      AppGlobal::singletonProvider);

  FolderSystem::registerType();
}

AppGlobal::AppGlobal()
    : QObject(), m_folder_system(std::make_unique<FolderSystem>()),
      m_router(std::make_unique<Router>()),
      m_themes(std::make_unique<Themes>()) {}

AppGlobal::~AppGlobal() {}

FolderSystem *AppGlobal::folderSystem() const { return m_folder_system.get(); }

Router *AppGlobal::router() const { return m_router.get(); }

Themes *AppGlobal::themes() const { return m_themes.get(); }