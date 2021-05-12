# Class for installing Puppet master preffered configuration
class profile::puppetmaster {

  service { 'puppetserver':
    ensure => running,
    enable => true
  }

#  class { 'puppetdb':
#    postgres_version => 'placeholder'
#    manage_firewall => false,
#  }

#  class { 'puppetdb::master::config': }

}
