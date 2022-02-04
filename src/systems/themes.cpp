#include "themes.h"

#include <QQmlEngine>

void Themes::registerType() {
  qmlRegisterUncreatableType<Themes>("UniversalLauncher", 1, 0, "Themes", "");
}

Themes::Themes(QObject *parent) : QObject(parent) {}
Themes::~Themes() {}
