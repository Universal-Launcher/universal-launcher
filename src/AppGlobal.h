#pragma once

#include <QObject>
#include <QQmlEngine>

#include <memory>

#include "systems/folders.h"
#include "systems/router.h"
#include "systems/settings.h"
#include "systems/themes.h"

class AppGlobal : public QObject {
  Q_OBJECT

  Q_PROPERTY(FolderSystem *folderSystem READ folderSystem);
  Q_PROPERTY(Router *router READ router CONSTANT);
  Q_PROPERTY(Themes *themes READ themes CONSTANT);
  Q_PROPERTY(SettingsSystem *settings READ settings CONSTANT);

public:
  AppGlobal();
  ~AppGlobal();

  static void registerType();
  static AppGlobal *instance();
  static void destroy();

  FolderSystem *folderSystem() const;
  Router *router() const;
  Themes *themes() const;
  SettingsSystem *settings() const;

private:
  std::unique_ptr<FolderSystem> m_folder_system;
  std::unique_ptr<Router> m_router;
  std::unique_ptr<Themes> m_themes;
  std::unique_ptr<SettingsSystem> m_settings;

  static QObject *singletonProvider(QQmlEngine *engine, QJSEngine *script);

  static AppGlobal *s_instance;
};
