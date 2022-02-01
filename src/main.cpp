#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QTranslator>

#include <QQmlDebuggingEnabler>

#include "AppGlobal.h"

void register_singletons() { AppGlobal::registerType(); }

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

  register_singletons();

  engine.load(QUrl(QStringLiteral("qrc:/qml/main/app.qml")));
  if (engine.rootObjects().isEmpty())
    QCoreApplication::exit(-1);

  // Show the application
  return app.exec();
}
