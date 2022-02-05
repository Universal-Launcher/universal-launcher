#include "themes.h"

#include <QQmlEngine>

void Themes::registerType() {
  qmlRegisterUncreatableType<Themes>("UniversalLauncher", 1, 0, "Themes", "");
  qmlRegisterUncreatableType<ThemeObject>("UniversalLauncher", 1, 0,
                                          "ThemeObject", "");
}

Themes::Themes(QObject *parent) : QObject(parent) {
  registerDefaultThemes();
  registerDarkThemes();
  registerSepiaThemes();

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
  values.insert("title_color", "#ffffff");
  values.insert("accent_color", "#F97316");

  m_themes.insert("default", new ThemeObject(values));
}

void Themes::registerDarkThemes() {
  ThemeObject::ThemeValues values{};
  values.insert("background_color", "#252525");
  values.insert("background_color_2", "#444444");
  values.insert("text_color", "#E5E7EB");
  values.insert("title_color", "#E5E7EB");
  values.insert("accent_color", "#F97316");

  m_themes.insert("dark", new ThemeObject(values));
}

void Themes::registerSepiaThemes() {
  ThemeObject::ThemeValues values{};
  values.insert("background_color", "#EAD09E");
  values.insert("background_color_2", "#D7A575");
  values.insert("text_color", "#B59860");
  values.insert("title_color", "#FFEBC6");
  values.insert("accent_color", "#white");

  m_themes.insert("sepia", new ThemeObject(values));
}
