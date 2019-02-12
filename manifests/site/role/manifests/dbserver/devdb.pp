class role::dbserver::devdb {
  include mysql::server
  include mysql::client
  include profile::dbserver::devdb
}