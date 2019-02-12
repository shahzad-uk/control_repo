node default {
  file { '/tmp/hello.txt':
  ensure  => file,
  content => "hello, world\n",
  }
}


node node1.puppet.vm {
	include role::apache::devserver
  #include role::jenkins::devmaster
}
