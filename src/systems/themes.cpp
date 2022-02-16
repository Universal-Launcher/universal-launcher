#include "themes.h"

#include <QQmlEngine>

void Themes::registerType() {
  qmlRegisterUncreatableType<Themes>("UniversalLauncher", 1, 0, "Themes", "");
  qmlRegisterUncreatableType<ThemeObject>("UniversalLauncher", 1, 0,
                                          "ThemeObject", "");
}

Themes::Themes(QObject *parent) : QObject(parent) {
  registerDefaultThemes();

  changeTheme(QString{"default"});
}
Themes::~Themes() {}

void Themes::changeTheme(const QString &themeName) {
  if (!m_themes.contains(themeName))
    return;

  m_current = themeName;

  emit themeChanged();
}

void Themes::changeTheme(const std::string &themeName) {
  changeTheme(QString::fromStdString(themeName));
}

ThemeObject *Themes::currentTheme() { return m_themes[m_current].get(); }

QString Themes::currentThemeName() { return m_current; }

QStringList Themes::themesList() {
  QStringList keys;
  for (auto const &el : m_themes) {
    keys.push_back(el.first);
  }
  return keys;
}

ThemeObject *Themes::getTheme(QString name) {
  if (!m_themes.contains(name))
    return nullptr;
  return m_themes[name].get();
}

void Themes::registerDefaultThemes() {
  ThemeObject::ThemeValues values{};

  values.insert("background_color", QVariant::fromValue<QString>("white"));
  values.insert("background_color_2", QVariant::fromValue<QString>("#E5E7EB"));
  values.insert("text_color", QVariant::fromValue<QString>("#374151"));
  values.insert("title_color", QVariant::fromValue<QString>("white"));
  values.insert("accent_color", QVariant::fromValue<QString>("#F97316"));
  values.insert("radius", QVariant::fromValue<uint16_t>(10));
  values.insert("minRadius", QVariant::fromValue<uint16_t>(5));
  m_themes.emplace("default",
                   QMemory::make_unique_qobject_ptr<ThemeObject>(values));

  values["background_color"] = QVariant::fromValue<QString>("#252525");
  values["background_color_2"] = QVariant::fromValue<QString>("#444444");
  values["text_color"] = QVariant::fromValue<QString>("#E5E7EB");
  values["title_color"] = QVariant::fromValue<QString>("#E5E7EB");
  values["accent_color"] = QVariant::fromValue<QString>("#F97316");
  values["radius"] = QVariant::fromValue<uint16_t>(10);
  values["minRadius"] = QVariant::fromValue<uint16_t>(5);
  m_themes.emplace("dark",
                   QMemory::make_unique_qobject_ptr<ThemeObject>(values));

  values["background_color"] = QVariant::fromValue<QString>("#EAD09E");
  values["background_color_2"] = QVariant::fromValue<QString>("#D7A575");
  values["text_color"] = QVariant::fromValue<QString>("#B59860");
  values["title_color"] = QVariant::fromValue<QString>("#FFEBC6");
  values["accent_color"] = QVariant::fromValue<QString>("white");
  values["radius"] = QVariant::fromValue<uint16_t>(0);
  values["minRadius"] = QVariant::fromValue<uint16_t>(0);
  m_themes.emplace("sepia",
                   QMemory::make_unique_qobject_ptr<ThemeObject>(values));

  emit themesListUpdated();
}
