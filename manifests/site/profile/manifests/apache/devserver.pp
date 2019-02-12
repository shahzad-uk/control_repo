class profile::apache::devserver {

	apache::vhost {'personal_site':
	  #Enum['On', 'Off'] $sendfile                       => 'Off',
	  Enum['On',' Off'] $suphp_engine                   => 'Off',
 	  port => 80,
		docroot => '/var/www/personal',
		options => 'Indexes MultiViews',
	}

}
