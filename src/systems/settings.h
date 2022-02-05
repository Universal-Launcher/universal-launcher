#pragma once

#include <QObject>
#include <QString>
#include <simdjson.h>

#include "folders.h"

using namespace simdjson;

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
  ondemand::document &get();

private:
  QString m_config_path;
  ondemand::parser m_parser;
  ondemand::document m_doc;
};
