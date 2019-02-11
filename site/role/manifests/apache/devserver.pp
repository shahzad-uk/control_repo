class role::apache::devserver {
  include profile::base
  include profile::server
  include profile::apache::devserver
}
