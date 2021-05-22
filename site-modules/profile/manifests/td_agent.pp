# Class for installing and customizng td-agent configuration

class profile::td_agent () {

  include fluentd

  fluentd::plugin { 'fluent-plugin-systemd': }

  fluentd::config { '100_systemd.conf':
    config => {
      'source' => [
        {
          'type' => 'systemd',
          'path' => '/var/log/journal',
          'tag'  => 'systemd',
        },
      ],
      'match'  => {
        'tag_pattern' => 'systemd',
        'type'        => 'file',
        'path'        => '/var/log/myapp',
      },
    },
  }

}


#<match pattern>
#  @type file
#  path /var/log/fluent/myapp
#  time_slice_format %Y%m%d
#  time_slice_wait 10m
#  time_format %Y%m%dT%H%M%S%z
#  compress gzip
#  utc
#</match>
