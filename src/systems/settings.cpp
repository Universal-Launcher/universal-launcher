#include "settings.h"

#include "qqmlengine.h"
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <string>

void SettingsSystem::registerType() {
  qmlRegisterUncreatableType<SettingsSystem>("UniversalLauncher", 1, 0,
                                             "SettingsSystem", "");
}

SettingsSystem::SettingsSystem(FolderSystem *folder_system) : QObject() {
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
  auto json = padded_string::load(m_config_path.toStdString());

  auto result = m_parser.iterate(json).get(m_doc);
  if (result != SUCCESS) {
    throw std::runtime_error(QString{"unable to open %1: %2"}
                                 .arg(m_config_path, result)
                                 .toStdString());
  }
}

void SettingsSystem::save() {
  QFile file(m_config_path);
  if (file.open(QIODevice::ReadWrite)) {
    QTextStream stream(&file);
    auto result = to_json_string(m_doc);

    if (result.error() != SUCCESS) {
      throw std::runtime_error(QString{"unable to save %1: %2"}
                                   .arg(m_config_path, result.error())
                                   .toStdString());
    }
    std::string output = result.value().data();
    stream << QString::fromStdString(output) << Qt::endl;
    file.close();
  }
}

void SettingsSystem::saveDefault() {
  auto json = R"({})"_padded;
  m_parser.iterate(json).get(m_doc);
  this->save();
}

ondemand::document &SettingsSystem::get() { return m_doc; }
