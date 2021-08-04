# comment
class profile::elasticsearch {
  include elasticsearch
  include elastic_stack::repo
  include prometheus::elasticsearch_exporter

  elasticsearch::plugin { 'x-pack': }

}
