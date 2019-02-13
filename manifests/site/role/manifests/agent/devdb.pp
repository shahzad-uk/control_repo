class role::agent::devdb {
  include mysql::client
  include profile::dbserver::devdb
}