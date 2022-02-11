#pragma once

#include "../AppGlobal.h"
#include "minecraft_profile.h"
#include <QObject>

class AccountsManager : public QObject {
  Q_OBJECT

  Q_PROPERTY(QList<MinecraftProfile *> accounts READ listAccounts NOTIFY
                 accountsListUpdated);

  Q_PROPERTY(MinecraftProfile *current READ currentAccount NOTIFY
                 currentAccountChanged)

public:
  ~AccountsManager();
  void registerType();

  static AccountsManager *instance();
  void set_engine(QQmlEngine *engine);

  void loadAccounts(AppGlobal *appGlobal);
  void addAccount(MinecraftProfile *profile);

  QList<MinecraftProfile *> listAccounts();

  MinecraftProfile *currentAccount() const;

public slots:
  void removeAccount(QString id);
  void switchAccount(QString id);

signals:
  void accountsListUpdated();
  void currentAccountChanged();

private:
  AccountsManager();

  static AccountsManager *s_instance;
  AppGlobal *m_appGlobal;
  QQmlEngine *m_engine;

  MinecraftProfile *m_currentAccount;
  std::map<QString, std::unique_ptr<MinecraftProfile>> m_accounts;
};
