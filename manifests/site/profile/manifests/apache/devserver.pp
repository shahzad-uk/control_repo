class profile::apache::devserver {
    $apache = $::osfamily ? {
		'RedHat' => 'httpd',
		'Debian' => 'apache2',
	}
	service { $apache:
	  enable => true,
	  ensure => true,	  
	}
	package { $apache:
	  ensure => 'installed',
	}
	
	apache::vhost {'personal_site':
	  #Enum['On', 'Off'] $sendfile                       => 'Off',
	  suphp_engine                   => 'off',
 	  port => 80,
		docroot => '/var/www/personal',
		options => 'Indexes MultiViews',
	}

}
