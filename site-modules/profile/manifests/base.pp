# Base profile applied to all nodes
class profile::base (
  Array $packages = [],
) {
  include profile::consul
  include prometheus
  ensure_packages($packages,{'ensure' => 'latest'})
}
