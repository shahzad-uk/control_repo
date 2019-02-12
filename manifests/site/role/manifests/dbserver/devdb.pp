class role::dbserver::devdb {
  include mysql::client
  include profile::dbserver::devdb
}