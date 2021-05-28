# A basic class for installing zookeeper

class profile::zookeeper {

  require profile::java

  class { 'zookeeper': }

}
