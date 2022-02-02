#pragma once

#include <QMap>
#include <QObject>
#include <QString>
#include <QUrl>

class Router : public QObject {
  Q_OBJECT

  Q_PROPERTY(QUrl currentRoute READ currentRoute NOTIFY routeChanged);
  Q_PROPERTY(QUrl currentRouteName READ currentRouteName NOTIFY routeChanged);

public:
  Router();
  ~Router();

  QUrl currentRoute();
  QString currentRouteName();
signals:
  void routeChanged(const QString &route);

public slots:
  void goTo(const QString &route);
  void registerRoute(const QString &route, const QUrl &url);
  bool isCurrentRoute(const QString &route) { return m_current_route == route; }

private:
  QString m_current_route;
  QMap<QString, QUrl> m_routes{};
};
