#use hiera
class profile::consul () {
  require profile::base
  include consul
}
