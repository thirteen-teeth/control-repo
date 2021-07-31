# Base profile applied to all nodes
class profile::base (
  Array $packages = [],
) {
  include profile::consul
  ensure_packages($packages, {'ensure' => 'present'})
}
