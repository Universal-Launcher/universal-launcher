#pragma once

#include <QObject>
#include <QQmlEngine>

#include <memory>

#include "systems/folders.h"
#include "systems/router.h"
#include "systems/themes.h"

class AppGlobal : public QObject {
  Q_OBJECT

  Q_PROPERTY(FolderSystem *folderSystem READ folderSystem);
  Q_PROPERTY(Router *router READ router CONSTANT);
  Q_PROPERTY(Themes *themes READ themes CONSTANT);

public:
  AppGlobal();
  ~AppGlobal();

  static void registerType();

  FolderSystem *folderSystem() const;
  Router *router() const;
  Themes *themes() const;

  int getCount() const { return 42; }

private:
  std::unique_ptr<FolderSystem> m_folder_system;
  std::unique_ptr<Router> m_router;
  std::unique_ptr<Themes> m_themes;

  static QObject *singletonProvider(QQmlEngine *engine, QJSEngine *script);
};