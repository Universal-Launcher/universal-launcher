#pragma once

#include "../QObjectMemory.h"
#include <QObject>
#include <QString>
#include <QStringList>
#include <QVariant>
#include <map>
#include <string>

class ThemeObject : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString backgroundColor READ backgroundColor CONSTANT);
  Q_PROPERTY(QString backgroundColor2 READ backgroundColor2 CONSTANT);
  Q_PROPERTY(QString textColor READ textColor CONSTANT);
  Q_PROPERTY(QString titleColor READ accentColor CONSTANT);
  Q_PROPERTY(QString accentColor READ accentColor CONSTANT);
  Q_PROPERTY(int radius READ radius CONSTANT);
  Q_PROPERTY(int minRadius READ minRadius CONSTANT);

public:
  using ThemeValues = QMap<QString, QVariant>;

  QString backgroundColor();
  QString backgroundColor2();
  QString textColor();
  QString titleColor();
  QString accentColor();
  uint16_t radius();
  uint16_t minRadius();

  ThemeObject();
  ThemeObject(ThemeValues &values);

private:
  ThemeValues m_values{};
};

class Themes : public QObject {
  Q_OBJECT

  Q_PROPERTY(ThemeObject *current READ currentTheme NOTIFY themeChanged)
  Q_PROPERTY(QStringList themesList READ themesList NOTIFY themesListUpdated)

public:
  Themes(QObject *parent = nullptr);
  ~Themes();

  static void registerType();

  ThemeObject *currentTheme();
  QString currentThemeName();
  QStringList themesList();

public slots:
  void changeTheme(const QString &themeName);
  void changeTheme(const std::string &themeName);
  ThemeObject *getTheme(QString name);

signals:
  void themeChanged();
  void themesListUpdated();

private:
  QString m_current = "default";
  std::map<QString, QMemory::unique_qobject_ptr<ThemeObject>> m_themes;

  void registerDefaultThemes();
};
