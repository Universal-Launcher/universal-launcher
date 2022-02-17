#include "settings.h"

#include "qqmlengine.h"
#include <QDir>
#include <QFile>
#include <string>

void SettingsSystem::registerType() {
  qmlRegisterUncreatableType<SettingsSystem>("UniversalLauncher", 1, 0,
                                             "SettingsSystem", "");
}

SettingsSystem::SettingsSystem(FolderSystem *folder_system, QObject *parent)
    : QObject(parent) {
  auto dir = QDir{folder_system->getFolderPath()};
  m_config_path = dir.absoluteFilePath("launcher.json");

  if (!dir.exists("launcher.json")) {
    this->saveDefault();
  } else {
    this->load();
  }
}

SettingsSystem::~SettingsSystem() {}

void SettingsSystem::load() {
  qDebug() << "Loading config from " << m_config_path;

  QFile jsonFile(m_config_path);
  if (jsonFile.open(QFile::ReadOnly) && jsonFile.size() > 0) {

    m_doc =
        nlohmann::json::parse(jsonFile.readAll().toStdString(), nullptr, false);
    jsonFile.close();
  } else {
    qDebug() << "Could not open config file";
    this->saveDefault();
  }
}

void SettingsSystem::save() {
  QFile file(m_config_path);
  if (file.open(QIODevice::ReadWrite | QIODevice::Truncate | QIODevice::Text) &&
      !m_doc.empty()) {

    file.write(QByteArray::fromStdString(nlohmann::to_string(m_doc)));
    file.close();
  }
}

void SettingsSystem::saveDefault() {
  m_doc = {};
  this->save();
}

nlohmann::json *SettingsSystem::get() { return &m_doc; }
