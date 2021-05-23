# Class for installing and customizng td-agent configuration

class profile::td_agent () {

  user { 'td-agent':
    ensure => 'present',
    groups => 'systemd-journal',
  }

  include fluentd

  fluentd::plugin { 'fluent-plugin-systemd': }
  fluentd::plugin { 'fluent-plugin-kafka': }

  fluentd::config { '100_systemd.conf':
    config => {
      'source' => [
        {
          'type' => 'systemd',
          'path' => '/run/log/journal/',
          'tag'  => 'systemd',
        },
      ],
      'match'  => {
        'tag_pattern'       => 'systemd**',
        'type'              => 'kakfa2',
        'brokers'           => 'kafka-host:9092',
        'use_event_time'    => 'true',
        'topic_key'         => 'rsyslog',
        'default_topic'     => 'rsyslog',
        'required_acks'     => '-1',
        'compression_codec' => 'gzip',
        'buffer topic'      => {
          'type'           => 'file',
          'path'           => '/tmp/buffer/td',
          'flush_interval' => '3s'
        },
        'format'            => {
          'type' => 'json',
        },
      },
    },
  }

}

#  <source>
#    path "/run/log/journal/"
#    tag "systemd"
#    @type systemd
#  </source>
#  <match systemd**>
#    @type kafka2
#    brokers kafka-host:9092
#    use_event_time true
#    topic_key "rsyslog"
#    default_topic "rsyslog"
#    required_acks -1
#    compression_codec "gzip"
#    <buffer topic>
#      @type "file"
#      path "/var/log/td-agent/buffer/td"
#      flush_interval 3s
#    </buffer>
#    <format>
#      @type "json"
#    </format>
#  </match>
