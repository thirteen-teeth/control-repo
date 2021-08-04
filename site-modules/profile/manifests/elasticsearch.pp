# comment
class profile::elasticsearch {
  include elasticsearch
  include elastic_stack::repo
  include prometheus::elasticsearch_exporter
  include profile::java
  include profile::java_ks
}
