#class
class role::opensearch {
  include profile::base
  include opensearch

  file { '/tmp/cert.tpl':
    content => template('profile/cert.tpl.erb')
  }

}
