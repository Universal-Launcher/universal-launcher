#include "router.h"

Router::Router() : QObject() {}

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
