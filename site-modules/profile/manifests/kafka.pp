# A basic class for installing kafka 

class profile::kafka (
  String $kafka_version = '2.8.0',
  String $scala_version = '2.13'
) {

  require profile::java
  require profile::zookeeper

  class { 'kafka':
    version       => $kafka_version,
    scala_version => $scala_version,
  }

  class { 'kafka::broker':
    config => {
      'broker.id'         => '1',
      'zookeeper.connect' => 'localhost:2181'
    }
  }

}
