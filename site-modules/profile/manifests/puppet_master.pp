# Class for installing Puppet master preffered configuration
class profile::puppet_master (
  $postgres_version = '10.17',
) {

  service { 'puppetserver':
    ensure => running,
    enable => true
  }

  class { 'puppetdb':
    listen_address  => '0.0.0.0',
    manage_firewall => false,
  }

  class { 'puppetdb::database::postgresql':
    postgres_version    => $postgres_version,
    manage_package_repo => false,
  }

#  class { 'puppetdb::master::config': }
# change me

}
