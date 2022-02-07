#pragma once

#include <QGuiApplication>
#include <QLocale>
#include <QObject>
#include <QPointer>
#include <QTranslator>

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

  void registerLanguages(QGuiApplication *app);

signals:
  void languageChanged();

public slots:
  void setLanguage(QString name);

private:
  QApplication *m_app;
  QPointer<QTranslator> m_translator{new QTranslator()};
  QMap<QString, QLocale> m_languages;
};
