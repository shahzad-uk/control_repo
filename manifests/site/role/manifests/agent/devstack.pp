class role::agent::devstack {
  include profile::apache::devserver
  include mysql::client
  include profile::dbserver::devdb
}