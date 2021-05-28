# A basic class for installing zookeeper

class profile::zookeeper {

  require profile::java

  class { 'zookeeper':
    install_method      => 'archive',
    archive_version     => '3.6.3',
    service_provider    => 'systemd',
    manage_service_file => true,
  }

}
