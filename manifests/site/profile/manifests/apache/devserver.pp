class profile::apache::devserver {

	apache::vhost {'personal_site':
	  port => 80,
		docroot => '/var/www/personal',
		options => 'Indexes MultiViews',
	}

}
