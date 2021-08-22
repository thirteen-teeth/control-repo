#class!
class role::prometheus {
  include profile::base
  include prometheus
  include grafana
}
