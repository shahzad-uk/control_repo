class profile::dbserver::devdb {

  class { '::mysql::server':
    root_password           => 'verystrongpassword',
    remove_default_accounts => true,
    log_bin => 'ON',
    bind_address => '0.0.0.0',
  }
  mysql::db {'devdb':
    user     => 'developer',
    password => 'developer',
    host     => '*',
    grant    => ['SELECT', 'UPDATE'],
  }

}