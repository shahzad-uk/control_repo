class profile::apache::prodserver {

	apache::vhost {'prod_site':
	  
	  suphp_engine                   => 'off',
 	  port => 80,
		docroot => '/var/www/production',
		options => 'Indexes MultiViews',
	}
    file { '/var/www/production/index.html':
      ensure  => file,
      content => "<H1>Welcome to Production Website</H1>\n",
    }

}