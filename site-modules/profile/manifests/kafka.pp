# A basic class for installing kafka 

class profile::kafka (
  String $kafka_version = '2.8.0',
  String $scala_version = '2.13',
  String $zookeeper_url = 'localhost:2181',
) {

  require profile::java
  require profile::zookeeper

  class { 'kafka':
    kafka_version => $kafka_version,
    scala_version => $scala_version,
  }

  class { 'kafka::broker':
    config => {
      'broker.id'         => '1',
      'zookeeper.connect' => $zookeeper_url,
    }
  }

  kafka::topic { 'systemd':
    ensure             => present,
    zookeeper          => $zookeeper_url,
    replication_factor => 1,
    partitions         => 3,
  }

}
