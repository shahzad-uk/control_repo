class role::apache::devserver {
  include apache::base
  include apache::server
  include profile::apache::devserver
}
