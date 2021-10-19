#class
class role::opensearch_dashboards {
  include profile::base
  include profile::opensearch_dashboards
  include role::logstash
}
