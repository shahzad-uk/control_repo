class profile::prodserver::webprod {
  include apache
	
	apache::vhost {'000-prod_site':
	  
	  suphp_engine                   => 'off',
 	  port => 80,
      servername => 'prod.puppet.vm',
	  docroot => '/var/www/production',
	  options => 'Indexes MultiViews',
	}
    file { '/var/www/production/index.html':
      ensure  => file,
      content => "<H1>Welcome to Production Website</H1>\n",
    }

}