#pragma once

#include <QMap>
#include <QObject>
#include <QString>
#include <QUrl>

class Router : public QObject {
  Q_OBJECT

  Q_PROPERTY(QUrl currentRoute READ currentRoute CONSTANT);

public:
  Router();
  ~Router();

signals:
  void onRouteChanged(QString route);

public slots:
  void goTo(QString route);
  void registerRoute(QString route, QUrl *url);

private:
  QString m_current_route;
  QMap<QString, QUrl> m_routes;

  QUrl currentRoute() { return QUrl{""}; }
};