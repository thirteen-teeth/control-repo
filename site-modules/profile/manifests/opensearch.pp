#Comment
class profile::opensearch () {

  include opensearch

  $cert_files = [ 'cert', 'private', 'ca']
  $cert_files.each |$name| {
    file { "/tmp/${name}.tpl":
      content => template("profile/consul_template/${name}.tpl.erb")
    }
  }

}
