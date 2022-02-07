#include "themes.h"

QString ThemeObject::backgroundColor() {return m_values["background_color"].value<QString>(); }
QString ThemeObject::backgroundColor2() {
  return m_values["background_color_2"].value<QString>();
}
QString ThemeObject::textColor() { return m_values["text_color"].value<QString>();}
QString ThemeObject::titleColor() { return m_values["title_color"].value<QString>();}
QString ThemeObject::accentColor() { return m_values["accent_color"].value<QString>(); }
uint16_t ThemeObject::radius() { return m_values["radius"].value<uint16_t>(); }
uint16_t ThemeObject::minRadius() { return m_values["minRadius"].value<uint16_t>(); }

ThemeObject::ThemeObject(ThemeValues values) : QObject() {
  this->m_values = values;
}
