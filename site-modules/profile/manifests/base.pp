# Base profile applied to all nodes
class profile::base (
  Array $packages = [],
) {
  include profile::consul

  package { $packages:
    ensure => latest,
  }

}
