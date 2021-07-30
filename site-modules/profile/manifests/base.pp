# Base profile applied to all nodes
class profile::base (
  Array $packages = [],
) {
  ensure_packages($packages, {'ensure' => 'present'})
}
