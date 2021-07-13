# a very basic role for a kafka_broker and zookeeper instances
class role::kafka_broker {
  include profile::zookeeper
  include profile::kafka
}
