class profile::apache::devserver {

	apache::vhost {'dev_site':
	  
	  suphp_engine                   => 'off',
 	  port => 80,
		docroot => '/var/www/dev',
		options => 'Indexes MultiViews',
	}
    file { '/var/www/production/index.html':
      ensure  => file,
      content => "<H1>Welcome to DEV Website</H1>\n",
    }
}
