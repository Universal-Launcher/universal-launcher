#include "translator.h"

#include <QDir>
#include <QQmlEngine>

void Translator::registerType() {
  qmlRegisterUncreatableType<Translator>("UniversalLauncher", 1, 0,
                                         "Translator", "");
}

Translator::Translator(QObject *parent) : QObject(parent) {
  QLocale::setDefault(QLocale::English);
}

Translator::~Translator() {}

void Translator::setLanguage(QString name) {
  if (!m_languages.contains(name))
    return;

  QLocale::setDefault(m_languages.value(name));
  emit languageChanged();
}

QString Translator::currentLanguage() { return m_translator->language(); }

QStringList Translator::languages() {
  QStringList values{};
  for (const QLocale &locale : m_languages.values()) {
    values.append(locale.nativeLanguageName());
  }
  return values;
}

void Translator::registerLanguages(QGuiApplication *app) {
  QStringList uiLanguages = QDir{":/i18n"}.entryList();

  for (const QString &name : uiLanguages) {
    m_translator->load(name);
    qDebug() << m_translator->language();
    m_languages.insert(name, QLocale{name});
  }

  app->installTranslator(m_translator.data());
}
