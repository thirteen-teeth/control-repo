# Class for installing Puppet master preffered configuration
class profile::puppet_master {

  service { 'puppetserver':
    ensure => running,
    enable => true
  }

  include puppetdb
  include puppetdb::master::config

}
