class role::agent::proddb {
  include mysql::client
  include profile::dbserver::proddb
}