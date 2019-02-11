class role::jenkins::server {
  include profile::base
  include profile::server
  include profile::apache::server
}
