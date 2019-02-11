class role::jenkins::devmaster {
  include profile::base
  include profile::server
  include profile::jenkins::devmaster
}
