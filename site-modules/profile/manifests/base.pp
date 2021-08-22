# Base profile applied to all nodes
class profile::base (
  Array $packages = [],
) {
  include profile::consul
  include prometheus::node_exporter
  ensure_packages($packages,{'ensure' => 'latest'})
}
