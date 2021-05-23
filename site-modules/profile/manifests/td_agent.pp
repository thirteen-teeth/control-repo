# Class for installing and customizng td-agent configuration

class profile::td_agent () {

  user { 'td-agent':
    ensure => 'present',
    group  => 'systemd-journal',
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
        {
          'type' => 'syslog',
          'port' => '5140',
          'bind' => '0.0.0.0',
          'tag'  => 'syslog'
        },
      ],
      'match'  => {
        'tag_pattern' => 'systemd**',
        'type'        => 'file',
        'path'        => '/tmp/syslog',
      },
    },
  }

}
