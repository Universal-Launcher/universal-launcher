#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QTranslator>
#include <QQmlContext>

#include <QDebug>

#include "auth/authentication.h"

static QObject* authSingletonTypeProvider(QQmlEngine* engine, QJSEngine* script) {
    Q_UNUSED(engine);
    Q_UNUSED(script);

    return Authentication::instance();
}

void register_types(QQmlEngine *engine) {
    qmlRegisterSingletonType<Authentication>("Authentication", 1, 0, "Authentication", authSingletonTypeProvider);
}

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
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    // Init types for further usage
    register_types(&engine);

    engine.load(url);

    // Show the application
    return app.exec();
}
