# Class for installing and customizng td-agent configuration

class profile::td_agent () {

  class { 'fluentd': }

}
