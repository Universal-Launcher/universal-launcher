#pragma once

#include <QGuiApplication>
#include <QLocale>
#include <QObject>
#include <QQmlEngine>
#include <QTranslator>
#include <memory>

class Translator : public QObject {
  Q_OBJECT

  Q_PROPERTY(
      QString currentLanguage READ currentLanguage NOTIFY languageChanged)
  Q_PROPERTY(QStringList languages READ languages CONSTANT)
public:
  Translator(QObject *parent = nullptr);
  ~Translator();

  static void registerType();

  QString currentLanguage();
  QStringList languages();

  void registerLanguages(QGuiApplication *app, QQmlEngine *engine);

signals:
  void languageChanged();

public slots:
  void setLanguage(QString name);
  void setLanguage(const std::string &name);
  QString getHumanName(QString name);

private:
  QGuiApplication *m_app;
  QQmlEngine *m_engine;
  QTranslator *m_translator;
  QMap<QString, QString> m_languages;
};
