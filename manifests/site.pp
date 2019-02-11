node /^node\d+\.puppet.vm$/ {
	include role::apache::master
	include role::jenkins::master
	
}
