#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QTranslator>

#include <QQmlDebuggingEnabler>

#include "AppGlobal.h"
#include <QPointer>

int main(int argc, char *argv[]) {
  QQmlDebuggingEnabler enabler;

  QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

  // Create the application instance
  QGuiApplication app(argc, argv);

  /*
   * Enabling translations
   */
  QTranslator translator;
  const QStringList uiLanguages = QLocale::system().uiLanguages();
  for (const QString &locale : uiLanguages) {
    const QString baseName = "universal-launcher_" + QLocale(locale).name();
    if (translator.load(":/i18n/" + baseName)) {
      app.installTranslator(&translator);
      break;
    }
  }

  /*
   * Load the view engine and the main view
   */
  QQmlApplicationEngine engine;

  QPointer<AppGlobal> appGlobal = AppGlobal::instance();
  appGlobal->registerType();
  appGlobal->settings()->load();

  bool alreadySetup;
  auto err = appGlobal->settings()->get()["configured"].get(alreadySetup);
  if (err)
    alreadySetup = false;

  alreadySetup = true;

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
