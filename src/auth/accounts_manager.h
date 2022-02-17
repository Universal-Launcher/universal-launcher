#pragma once

#include "../AppGlobal.h"
#include "../QObjectMemory.h"
#include "minecraft_profile.h"
#include <QObject>
#include <qt_mcauth/qt_mcauth.h>

class AccountsManager : public QObject {
  Q_OBJECT

  Q_PROPERTY(QList<MinecraftProfile *> accounts READ listAccounts NOTIFY
                 accountsListUpdated);

  Q_PROPERTY(MinecraftProfile *current READ currentAccount NOTIFY
                 currentAccountChanged)
  Q_PROPERTY(QString currentID READ currentID NOTIFY currentAccountChanged)

public:
  ~AccountsManager();
  void registerType();

  static AccountsManager *instance();
  void set_engine(QQmlEngine *engine);

  void loadAccounts(AppGlobal *appGlobal);

  QList<MinecraftProfile *> listAccounts();

  MinecraftProfile *currentAccount() const;
  QString currentID();

public slots:
  void addAccount();
  void removeAccount(QString id);
  void switchAccount(QString id);
  void cancelLogin();

signals:
  void accountsListUpdated();
  void currentAccountChanged();
  void authMessage(const QString &msg);

private:
  AccountsManager();

  void saveAccounts();
  void refreshAccount(MinecraftProfile *profile);
  void processFlow(Flow *flow);

  static AccountsManager *s_instance;
  AppGlobal *m_appGlobal;
  QQmlEngine *m_engine;

  MinecraftProfile *m_currentAccount = nullptr;
  std::map<QString, QMemory::unique_qobject_ptr<MinecraftProfile>> m_accounts;
  QMemory::unique_qobject_ptr<MCAuth> m_mcAuth;
  QMemory::unique_qobject_ptr<Flow> m_flow;
};
