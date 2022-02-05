#pragma once

#include <QObject>
#include <QQmlEngine>

#include <QPointer>

#include "systems/folders.h"
#include "systems/router.h"
#include "systems/settings.h"
#include "systems/themes.h"

class AppGlobal : public QObject {
  Q_OBJECT

  Q_PROPERTY(FolderSystem *folderSystem READ folderSystem CONSTANT);
  Q_PROPERTY(Router *router READ router CONSTANT);
  Q_PROPERTY(Themes *themes READ themes CONSTANT);
  Q_PROPERTY(SettingsSystem *settings READ settings CONSTANT);

public:
  ~AppGlobal();

  static AppGlobal *instance();
  static void destroy();
  void registerType();

  Q_INVOKABLE FolderSystem *folderSystem();
  Q_INVOKABLE Router *router();
  Q_INVOKABLE Themes *themes();
  Q_INVOKABLE SettingsSystem *settings();

private:
  AppGlobal();

  QPointer<FolderSystem> m_folder_system;
  QPointer<Router> m_router;
  QPointer<Themes> m_themes;
  QPointer<SettingsSystem> m_settings;

  static AppGlobal *s_instance;
};
