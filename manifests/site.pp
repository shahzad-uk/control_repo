node master.puppet.vm {
  file { '/tmp/hello.txt':
  ensure  => file,
  content => "Puppet is DEPLOYED now !!!\n",
  }
}


node node1.puppet.vm {
	include role::agent::devweb
  include role::agent::devdb
}

node node2.puppet.vm {
	include role::agent::prodweb
  include role::agent::proddb
}