class profile::apache::devserver {

	apache::vhost {'000-dev_site':
	  
	  suphp_engine                   => 'off',
 	  port => 80,
	  servername => 'dev.puppet.vm',
	  docroot => '/var/www/dev',
	  options => 'Indexes MultiViews',
	}
    file { '/var/www/dev/index.html':
      ensure  => file,
      content => "<H1>Welcome to DEV Website</H1>\n",
    }
}
