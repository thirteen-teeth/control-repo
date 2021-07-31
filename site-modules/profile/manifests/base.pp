# Base profile applied to all nodes
class profile::base (
  Array $packages = [],
) {
  include profile::consul

  stage { 'pre':
    before => Stage['main'],
  }

  package { $packages:
    ensure => latest,
    stage  => 'pre',
  }

}
