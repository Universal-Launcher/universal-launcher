#include "translator.h"

#include <QDir>
#include <QQmlEngine>

void Translator::registerType() {
  qmlRegisterUncreatableType<Translator>("UniversalLauncher", 1, 0,
                                         "Translator", "");
}

Translator::Translator(QObject *parent) : QObject(parent) {
  m_translator = new QTranslator();
  QLocale::setDefault(QLocale::English);
}

Translator::~Translator() { delete m_translator; }

void Translator::setLanguage(QString name) {
  if (!m_languages.contains(name) || !m_translator)
    return;

  if (!m_translator->isEmpty())
    m_app->removeTranslator(m_translator);
  m_translator->load(m_languages.value(name));

  m_app->installTranslator(m_translator);

  emit languageChanged();
  m_engine->retranslate();
}

void Translator::setLanguage(const std::string &name) {
  setLanguage(QString::fromStdString(name));
}

QString Translator::currentLanguage() { return m_translator->language(); }

QStringList Translator::languages() {
  QStringList values{};
  for (const QString &name : m_languages.keys()) {
    values.append(name);
  }
  return values;
}

void Translator::registerLanguages(QGuiApplication *app, QQmlEngine *engine) {
  QStringList uiLanguages = QDir{":/i18n"}.entryList();

  m_app = app;
  m_engine = engine;

  for (const QString &name : uiLanguages) {
    m_translator->load(name, QStringLiteral(":/i18n"));
    m_languages.insert(m_translator->language(), m_translator->filePath());
  }

  this->setLanguage(QString{"en_GB"});
}

QString Translator::getHumanName(QString name) {
  return QLocale(name).nativeLanguageName();
}
