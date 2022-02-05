#include "themes.h"

QString ThemeObject::backgroundColor() { return m_values["background_color"]; }
QString ThemeObject::backgroundColor2() {
  return m_values["background_color_2"];
}
QString ThemeObject::textColor() { return m_values["text_color"]; }
QString ThemeObject::titleColor() { return m_values["title_color"]; }
QString ThemeObject::accentColor() { return m_values["accent_color"]; }

ThemeObject::ThemeObject(ThemeValues values) : QObject() {
  this->m_values = values;
}
