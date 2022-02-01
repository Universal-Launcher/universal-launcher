#include "router.h"

Router::Router() : QObject() {}

Router::~Router() {}

void Router::goTo(QString route) {}

void Router::registerRoute(QString route, QUrl *url) {}