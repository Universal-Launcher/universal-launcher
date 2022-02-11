#pragma once

#include <QObject>
#include <QQmlEngine>
#include <memory>

#include "systems/folders.h"
#include "systems/router.h"
#include "systems/settings.h"
#include "systems/themes.h"
#include "systems/translator.h"

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

  std::unique_ptr<FolderSystem> m_folder_system;
  std::unique_ptr<Router> m_router;
  std::unique_ptr<Themes> m_themes;
  std::unique_ptr<SettingsSystem> m_settings;
  std::unique_ptr<Translator> m_translator;

  static AppGlobal *s_instance;
};
