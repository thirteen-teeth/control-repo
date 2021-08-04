# comment
class profile::elasticsearch (
  String $ssl_dir = '/etc/puppetlabs/puppet/ssl',
  String $user = 'elasticsearch',
) {

  include elasticsearch
  include elastic_stack::repo
  include prometheus::elasticsearch_exporter
  include profile::java
  include profile::java_ks

  posix_acl { $ssl_dir:
    action     => set,
    permission => ["user:${user}:r-X"],
    provider   => 'posixacl',
    recursive  => true,
  }

  posix_acl { "${ssl_dir}/private_keys/${facts['fqdn']}.pem":
    action     => set,
    permission => ["user:${user}:r"],
    provider   => 'posixacl',
  }


}
