class role::agent::prodstack {
  include mysql::client
  include profile::dbserver::proddb
  include profile::apache::prodserver
}