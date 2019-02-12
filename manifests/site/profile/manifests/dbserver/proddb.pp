class profile::dbserver::proddb {

  class { '::mysql::server':
    root_password           => 'verystrongpassword',
    remove_default_accounts => true,
    log_bin => 'ON',
    bind_address => '0.0.0.0',
  }
  mysql::db {'proddb':
    user     => 'www',
    password => 'www',
    host     => '*.puppet.vm',
    grant    => ['SELECT', 'UPDATE'],
  }

}