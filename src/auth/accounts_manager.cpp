#include "accounts_manager.h"

#include <QQmlContext>
#include <QQmlEngine>

AccountsManager *AccountsManager::s_instance = nullptr;

AccountsManager *AccountsManager::instance() {
  if (!s_instance) {
    s_instance = new AccountsManager();
  }
  return s_instance;
}

void AccountsManager::set_engine(QQmlEngine *engine) { m_engine = engine; }

void AccountsManager::registerType() {
  qmlRegisterSingletonType<AccountsManager>(
      "UniversalLauncher", 1, 0, "AccountsManager",
      [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);
        return AccountsManager::instance();
      });
}

AccountsManager::AccountsManager() : QObject() {}

AccountsManager::~AccountsManager() {}

void AccountsManager::loadAccounts(AppGlobal *appGlobal) {
  m_appGlobal = appGlobal;
}

void AccountsManager::addAccount(MinecraftProfile *profile) {
  m_accounts.emplace(profile->id(), profile);

  emit accountsListUpdated();
}

void AccountsManager::removeAccount(QString id) {
  m_accounts.erase(id);

  emit accountsListUpdated();
}

QList<MinecraftProfile *> AccountsManager::listAccounts() {
  QList<MinecraftProfile *> accounts;

  for (auto &kv : m_accounts) {
    accounts.append(kv.second.get());
  }

  return accounts;
}

void AccountsManager::switchAccount(QString id) {
  if (m_accounts.contains(id)) {
    m_currentAccount = m_accounts[id].get();

    emit currentAccountChanged();
  }
}

MinecraftProfile *AccountsManager::currentAccount() const {
  return m_currentAccount;
}
