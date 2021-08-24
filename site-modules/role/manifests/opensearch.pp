#class
class role::opensearch {
  include profile::base
  include opensearch
  include profile::java_ks

  sysctl { 'vm.max_map_count':
    ensure => present,
    value  => '262144',
  }

}
