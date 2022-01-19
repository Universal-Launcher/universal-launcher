#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QTranslator>
#include <QQmlContext>

#include <QDebug>

#include "auth/authentication.h"

int main(int argc, char *argv[])
{
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
    const QUrl url(QStringLiteral("qrc:/qml/app.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    // Init types for further usage
    Authentication::registerSingleton(&engine);

    engine.load(url);

    // Show the application
    return app.exec();
}
