#include "themes.h"

#include <QQmlEngine>

void Themes::registerType() {
  qmlRegisterUncreatableType<Themes>("UniversalLauncher", 1, 0, "Themes", "");
  qmlRegisterUncreatableType<ThemeObject>("UniversalLauncher", 1, 0,
                                          "ThemeObject", "");
}

Themes::Themes(QObject *parent) : QObject(parent) {
  registerDefaultThemes();
  changeTheme("default");
}
Themes::~Themes() {}

void Themes::changeTheme(const QString &themeName) {
  if (!m_themes.contains(themeName))
    return;

  m_current = m_themes[themeName].data();

  emit themeChanged();
}

ThemeObject *Themes::currentTheme() { return m_current; }

void Themes::registerDefaultThemes() {
  ThemeObject::ThemeValues values{};
  values.insert("background_color", "white");
  values.insert("background_color_2", "#E5E7EB");
  values.insert("text_color", "black");
  values.insert("accent_color", "#F97316");

  m_themes.insert("default", new ThemeObject(values));
}
