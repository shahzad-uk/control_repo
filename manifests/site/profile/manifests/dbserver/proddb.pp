class profile::dbserver::proddb {
  include mysql::client
  
  class { '::mysql::server':
    root_password           => 'verystrongpassword',
    remove_default_accounts => true,
    override_options => $override_options
  }
  $override_options = {
    'mysqld' => {
      'log-bin' => 'ON',
      'bind-address' => '0.0.0.0',
      'log-error' => '/var/log/mysqld.log',
    }
  }
  mysql::db {'proddb':
    user     => 'www',
    password => 'www',
    host     => 'prod.puppet.vm',
    grant    => ['SELECT', 'UPDATE'],
  }

}