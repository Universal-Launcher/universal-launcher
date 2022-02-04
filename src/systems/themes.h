#pragma once

#include <QObject>

class Themes : public QObject {
  Q_OBJECT

public:
  Themes(QObject *parent = nullptr);
  ~Themes();

  static void registerType();
};
