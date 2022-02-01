#pragma once

#include <QObject>
#include <QString>

class FolderSystem : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString launcherFolder READ getFolderPath CONSTANT);

public:
  FolderSystem();
  ~FolderSystem();

  static void registerType();

  QString getFolderPath() { return m_launcher_folder_path; }

public slots:
  void openLauncherFolder();

private:
  QString m_launcher_folder_path{"/home/louis"};
};