#pragma once

#include <QMap>
#include <QObject>
#include <QPointer>
#include <QString>
#include <QStringList>
#include <QVariant>
#include <memory>

class ThemeObject : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString backgroundColor READ backgroundColor CONSTANT);
  Q_PROPERTY(QString backgroundColor2 READ backgroundColor2 CONSTANT);
  Q_PROPERTY(QString textColor READ textColor CONSTANT);
  Q_PROPERTY(QString titleColor READ accentColor CONSTANT);
  Q_PROPERTY(QString accentColor READ accentColor CONSTANT);

public:
  using ThemeValues = QMap<QString, QVariant>;

  QString backgroundColor();
  QString backgroundColor2();
  QString textColor();
  QString titleColor();
  QString accentColor();

  ThemeObject();
  ThemeObject(ThemeValues values);

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
  QStringList themesList();

public slots:
  void changeTheme(const QString &themeName);
  ThemeObject *getTheme(QString name);

signals:
  void themeChanged();
  void themesListUpdated();

private:
  ThemeObject *m_current = nullptr;
  QMap<QString, QPointer<ThemeObject>> m_themes;

  void registerDefaultThemes();
};
