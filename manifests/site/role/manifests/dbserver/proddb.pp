class role::dbserver::proddb {
  include mysql::server
  include mysql::client
  include profile::dbserver::proddb
}