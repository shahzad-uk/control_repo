node /^node\d+\.puppet.vm$/ {
	include role::apache::server
	include role::jenkins::master
}
