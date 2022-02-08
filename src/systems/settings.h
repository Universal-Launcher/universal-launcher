#pragma once

#include <QObject>
#include <QString>
#include <nlohmann/json.hpp>

#include "folders.h"

class SettingsSystem : public QObject {
  Q_OBJECT

public:
  SettingsSystem(FolderSystem *folder_system, QObject *parent);
  ~SettingsSystem();

  static void registerType();

public slots:
  void load();
  void save();
  void saveDefault();
  nlohmann::json *get();

private:
  QString m_config_path;
  nlohmann::json m_doc{};
};
