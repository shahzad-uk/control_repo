class profile::dbserver::proddb {

  class { '::mysql::server':
    root_password           => 'verystrongpassword',
    remove_default_accounts => true,
    override_options => $override_options
  }
  $override_options = {
    'mysqld' => {
      'log_bin' => 'ON',
      'bind_address' => '0.0.0.0',
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