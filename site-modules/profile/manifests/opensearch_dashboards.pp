#comment
class profile::opensearch_dashboards (
  $source_templates
) {
  include opensearch_dashboards

  $source_templates.each |$name| {
    file { "/tmp/${name}.tpl":
      content => template("profile/consul_template/${name}.tpl.erb")
    }
  }

}
