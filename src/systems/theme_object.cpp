#include "themes.h"

QString ThemeObject::backgroundColor() {return m_values["background_color"].value<QString>(); }
QString ThemeObject::backgroundColor2() {
  return m_values["background_color_2"].value<QString>();
}
QString ThemeObject::textColor() { return m_values["text_color"].value<QString>();}
QString ThemeObject::titleColor() { return m_values["title_color"].value<QString>();}
QString ThemeObject::accentColor() { return m_values["accent_color"].value<QString>(); }

ThemeObject::ThemeObject(ThemeValues values) : QObject() {
  this->m_values = values;
}
