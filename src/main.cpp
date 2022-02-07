#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlDebuggingEnabler>

#include "AppGlobal.h"
#include <QPointer>

#include <QDir>

int main(int argc, char *argv[]) {
  QQmlDebuggingEnabler enabler;

  QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

  // Create the application instance
  QGuiApplication app(argc, argv);

  /*
   * Load the view engine and the main view
   */
  QQmlApplicationEngine engine;

  QPointer<AppGlobal> appGlobal = AppGlobal::instance();
  appGlobal->registerType();
  appGlobal->translator()->registerLanguages(&app, &engine);
  appGlobal->settings()->load();

  bool alreadySetup;
  auto err = appGlobal->settings()->get()["configured"].get(alreadySetup);
  if (err)
    alreadySetup = false;

  alreadySetup = false;

  if (alreadySetup) {
    engine.load(QUrl(QStringLiteral("qrc:/qml/main/MainWindow.qml")));
  } else {
    engine.load(QUrl(QStringLiteral("qrc:/qml/setup/SetupWindow.qml")));
  }

  if (engine.rootObjects().isEmpty()) {
    AppGlobal::destroy();
    QCoreApplication::exit(-1);
  }

  // Show the application
  return app.exec();
}
