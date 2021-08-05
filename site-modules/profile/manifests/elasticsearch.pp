# comment
class profile::elasticsearch (
  String $ssl_dir = '/etc/puppetlabs/puppet/ssl',
  String $user = 'elasticsearch',
) {

  include elasticsearch
  include elastic_stack::repo
  include prometheus::elasticsearch_exporter
}
