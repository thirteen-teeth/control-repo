# Base profile applied to all nodes
class profile::base {

  ensure_packages(['vim','bash-completion'], {'ensure' => 'present'})

}
