#include "folders.h"

#include "qqmlengine.h"
#include <QDesktopServices>
#include <QDir>
#include <QStandardPaths>
#include <QUrl>

void FolderSystem::registerType() {
  qmlRegisterUncreatableType<FolderSystem>("UniversalLauncher", 1, 0,
                                           "FolderSystem", "");
}

FolderSystem::FolderSystem() : QObject() {
  m_launcher_folder_path =
      QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

  QDir folder;

  if (!folder.exists(m_launcher_folder_path)) {
    bool result = folder.mkpath(m_launcher_folder_path);

    if (!result) {
      qFatal("Can't create launcher directory path");
    }
  }
}

FolderSystem::~FolderSystem() {}

void FolderSystem::openLauncherFolder() {
  QDesktopServices::openUrl(QUrl::fromLocalFile(m_launcher_folder_path));
}