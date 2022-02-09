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

  auto settings = appGlobal->settings()->get();
  bool alreadySetup = false;
  if (settings->contains("configured") &&
      settings->at("configured").is_boolean()) {
    alreadySetup = settings->at("configured").get<bool>();
  }

  if (alreadySetup) {
    if (settings->contains("theme") && settings->at("theme").is_string()) {
      appGlobal->themes()->changeTheme(
          settings->at("theme").get<std::string>());
    }

    if (settings->contains("language") &&
        settings->at("language").is_string()) {
      appGlobal->translator()->setLanguage(
          settings->at("language").get<std::string>());
    }

    engine.load(QUrl("qrc:/qml/main/MainWindow.qml"));
  } else {
    app.connect(appGlobal.data(), &AppGlobal::setupFinished, &app, [&engine]() {
      engine.load(QUrl("qrc:/qml/main/MainWindow.qml"));
    });
    engine.load(QUrl("qrc:/qml/setup/SetupWindow.qml"));
  }

  if (engine.rootObjects().isEmpty()) {
    QCoreApplication::exit(-1);
  }

  // Show the application
  return app.exec();
}
