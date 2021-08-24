#class
class role::opensearch {
  include profile::base
  include opensearch
  include profile::java_ks
}
