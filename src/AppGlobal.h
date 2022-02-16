#pragma once

#include <QObject>
#include <QQmlEngine>
#include <memory>

#include "memory.h"
#include "systems/folders.h"
#include "systems/router.h"
#include "systems/settings.h"
#include "systems/themes.h"
#include "systems/translator.h"

#include "QObjectMemory.h"

class AppGlobal : public QObject {
  Q_OBJECT

  Q_PROPERTY(FolderSystem *folderSystem READ folderSystem CONSTANT);
  Q_PROPERTY(Router *router READ router CONSTANT);
  Q_PROPERTY(Themes *themes READ themes CONSTANT);
  Q_PROPERTY(SettingsSystem *settings READ settings CONSTANT);
  Q_PROPERTY(Translator *translator READ translator CONSTANT);

public:
  ~AppGlobal();

  static AppGlobal *instance();
  void registerType();

  FolderSystem *folderSystem();
  Router *router();
  Themes *themes();
  SettingsSystem *settings();
  Translator *translator();

public slots:
  void finishSetup();

signals:
  void setupFinished();

private:
  AppGlobal();

  QMemory::unique_qobject_ptr<FolderSystem> m_folder_system;
  QMemory::unique_qobject_ptr<Router> m_router;
  QMemory::unique_qobject_ptr<Themes> m_themes;
  QMemory::unique_qobject_ptr<SettingsSystem> m_settings;
  QMemory::unique_qobject_ptr<Translator> m_translator;

  static AppGlobal *s_instance;
};
