#class for vault

class profile::vault () {

  class { 'vault':
    version   => '1.8.1',
    enable_ui => true,
  }

}
