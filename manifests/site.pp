node default {
  include "role::${::role}"
}

node node1.puppet.vm {
	include role::apache::devserver,
	include role::jenkins::master,
}
