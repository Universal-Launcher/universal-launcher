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

  values.insert("background_color", QVariant::fromValue<QString>("white"));
  values.insert("background_color_2", QVariant::fromValue<QString>("#E5E7EB"));
  values.insert("text_color", QVariant::fromValue<QString>("black"));
  values.insert("title_color", QVariant::fromValue<QString>("white"));
  values.insert("accent_color", QVariant::fromValue<QString>("#F97316"));
  m_themes.insert("default", new ThemeObject(values));

  values["background_color"] = QVariant::fromValue<QString>("#252525");
  values["background_color_2"] = QVariant::fromValue<QString>("#444444");
  values["text_color"] = QVariant::fromValue<QString>("#E5E7EB");
  values["title_color"] = QVariant::fromValue<QString>("#E5E7EB");
  values["accent_color"] = QVariant::fromValue<QString>("#F97316");
  m_themes.insert("dark", new ThemeObject(values));

  values["background_color"] = QVariant::fromValue<QString>("#EAD09E");
  values["background_color_2"] = QVariant::fromValue<QString>("#D7A575");
  values["text_color"] = QVariant::fromValue<QString>("#B59860");
  values["title_color"] = QVariant::fromValue<QString>("#FFEBC6");
  values["accent_color"] = QVariant::fromValue<QString>("white");
  m_themes.insert("sepia", new ThemeObject(values));
}