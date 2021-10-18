#comment
class profile::opensearch_dashboards {

  include opensearch_dashboards

  $cert_files = [ 'cert', 'private', 'ca']
  $cert_files.each |$name| {
    file { "/tmp/${name}.tpl":
      content => template("profile/consul_template/${name}.tpl.erb")
    }
  }

}
