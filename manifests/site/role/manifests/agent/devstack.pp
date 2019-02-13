class role::agent::devstack {
  include profile::apache::devserver
  include profile::dbserver::devdb
}