#class
class role::opensearch {
  include profile::base
  include opensearch

  file { '/tmp/cert.tpl':
    content => template('profile/consul_template/cert.tpl.erb')
  }

}
