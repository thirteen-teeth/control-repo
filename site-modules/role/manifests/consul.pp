#simple consul class
class role::consul () {
  include profile::base
  include profile::consul
}
