#comment
class profile::opensearch (
  $source_templates
) {
  include opensearch

  $source_templates.each |$name| {
    file { "/tmp/${name}.tpl":
      content => template("profile/consul_template/${name}.tpl.erb")
    }
  }

}
