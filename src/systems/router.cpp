#include "router.h"

#include <QQmlEngine>

void Router::registerType() {
  qmlRegisterUncreatableType<Router>("UniversalLauncher", 1, 0, "Router", "");
}

Router::Router(QObject *parent) : QObject(parent) {}

Router::~Router() {}

void Router::goTo(const QString &route) {
  m_current_route = route;
  emit routeChanged(route);
}

void Router::registerRoute(const QString &route, const QUrl &url) {
  m_routes.insert(route, url);
}

QUrl Router::currentRoute() {
  return m_routes.contains(m_current_route) ? m_routes[m_current_route]
                                            : QUrl{""};
}

QString Router::currentRouteName() {
  return m_routes.contains(m_current_route) ? m_current_route : "";
}
