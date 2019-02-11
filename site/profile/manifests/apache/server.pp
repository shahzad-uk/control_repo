class profile::apache::server {

  class { 'ntp':
	  enable => false;
	}
	apache::vhost {'personal_site':
	  port => 80,
		docroot => '/var/www/personal',
		options => 'Indexes MultiViews',
	}

}
