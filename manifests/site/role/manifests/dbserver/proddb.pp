class role::dbserver::proddb {
  include mysql::client
  include profile::dbserver::proddb
}