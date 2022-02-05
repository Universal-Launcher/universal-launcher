#pragma once

#include <QMap>
#include <QObject>
#include <QPointer>
#include <QString>
#include <memory>

class ThemeObject : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString backgroundColor READ backgroundColor CONSTANT);
  Q_PROPERTY(QString backgroundColor2 READ backgroundColor2 CONSTANT);
  Q_PROPERTY(QString textColor READ textColor CONSTANT);
  Q_PROPERTY(QString accentColor READ accentColor CONSTANT);

public:
  using ThemeValues = QMap<QString, QString>;

  QString backgroundColor();
  QString backgroundColor2();
  QString textColor();
  QString accentColor();

  ThemeObject();
  ThemeObject(ThemeValues values);

private:
  QMap<QString, QString> m_values{};
};

class Themes : public QObject {
  Q_OBJECT

  Q_PROPERTY(ThemeObject *current READ currentTheme NOTIFY themeChanged)

public:
  Themes(QObject *parent = nullptr);
  ~Themes();

  static void registerType();

  ThemeObject *currentTheme();

public slots:
  void changeTheme(const QString &themeName);

signals:
  void themeChanged();

private:
  ThemeObject *m_current = nullptr;
  QMap<QString, QPointer<ThemeObject>> m_themes;

  void registerDefaultThemes();
};
