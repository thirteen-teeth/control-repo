#use hiera
class profile::consul () {
  ensure_packages(['unzip'], {'ensure' => 'latest'})
  include consul
  include consul_template
}
