#include "accounts_manager.h"

#include <QQmlContext>
#include <QQmlEngine>

#include "../AppGlobal.h"
#include <secrets.h>

using json = nlohmann::json;

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

AccountsManager::AccountsManager() : QObject() {
  m_mcAuth =
      QMemory::make_unique_qobject_ptr<MCAuth>(Secrets::getMSAClientID());
}

AccountsManager::~AccountsManager() {}

void AccountsManager::loadAccounts(AppGlobal *appGlobal) {
  m_appGlobal = appGlobal;

  auto settings = AppGlobal::instance()->settings();

  if (!settings->get()->contains("accounts"))
    return;

  auto &accounts = settings->get()->at("accounts");

  for (auto &[key, val] : accounts.items()) {
    MinecraftProfile *profile = MinecraftProfile::fromJson(val);
    profile->setTokens(
        QString::fromStdString(val.at("access_token").get<std::string>()),
        QString::fromStdString(val.at("refresh_token").get<std::string>()));
    profile->setAvatar(
        QString::fromStdString(val.at("avatar").get<std::string>()));

    this->refreshAccount(profile);

    m_accounts.emplace(profile->id(), profile);
  }
}

void AccountsManager::refreshAccount(MinecraftProfile *profile) {}

void AccountsManager::addAccount() {
  m_flow = QMemory::unique_qobject_ptr<Flow>(m_mcAuth->loginAccount());

  connect(m_flow.get(), &Flow::message,
          [&](const FlowState &state, const QString &message) {
            emit authMessage(message);
          });

  connect(m_flow.get(), &Flow::finished, [&](const FlowState &state) {
    if (state == FlowState::Succeed) {
      emit authMessage(tr("Authentication finished"));
      auto account = m_mcAuth->getAccount();

      auto mcAccount = MinecraftProfile::fromMCAuth(account.value());
      mcAccount->setTokens(m_mcAuth->getAccessToken(),
                           m_mcAuth->getRefreshToken());

      if (m_accounts.contains(mcAccount->id())) {
        m_accounts[mcAccount->id()].reset(mcAccount);
      } else {
        m_accounts.emplace(mcAccount->id(), mcAccount);
      }

      saveAccounts();
    } else if (state == FlowState::Failed) {
      emit authMessage(tr("Authentication failed"));
    } else if (state == FlowState::Stopped) {
      emit authMessage(tr("Authentication stopped"));
    }

    emit accountsListUpdated();
  });

  m_flow->execute();
}

void AccountsManager::removeAccount(QString id) {
  m_accounts.erase(id);

  saveAccounts();

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

void AccountsManager::saveAccounts() {
  auto settings = AppGlobal::instance()->settings();

  if (!settings->get()->contains("accounts")) {
    settings->get()->push_back({"accounts", json::object()});
  }

  auto &accounts = settings->get()->at("accounts");

  for (auto &kv : m_accounts) {
    auto a = kv.second.get();

    accounts[kv.first.toStdString()] =
        json{{"id", a->id().toStdString()},
             {"name", a->username().toStdString()},
             {"avatar", a->avatar().toString().toStdString()},
             {"access_token", a->accessToken().toStdString()},
             {"refresh_token", a->refreshToken().toStdString()}};
  }

  settings->save();
}

void AccountsManager::cancelLogin() {
  if (m_flow) {
    m_flow->stop();
    m_flow.reset();
  }
}
