class role::agent::devstack {
  include profile::devserver::webdev
  include profile::devserver::devdb
}