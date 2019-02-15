node master.puppet.vm {
  file { '/tmp/hello.txt':
  ensure  => file,
  content => "Puppet is DEPLOYED now !!!\n",
  }
}


node node1.puppet.vm {
	include role::agent::devstack
  class { 'ntp':
    servers => ['3.uk.pool.ntp.org', '2.uk.pool.ntp.org']
  }
}

node node2.puppet.vm {
	include role::agent::prodstack
  
}
