#comment
class opensearch_dashboards::service {

  $unit_file         = 'opensearch-dashboards.service'
  $systemd_dir       = '/etc/systemd/system'
  $service_unit_name = "${systemd_dir}/${unit_file}"
  $service_exec_name = 'opensearch-dashboards-daemon-reload'
  $clean_systemd     = 'opensearch-dashboards-clean-systemd'
  $service_name      = 'opensearch-dashboards'

  if $opensearch_dashboards::ensure == 'present' {

    file { $service_unit_name:
      content => template("opensearch_dashboards/${unit_file}.erb"),
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Class[$opensearch_dashboards::config],
      notify  => Exec[$service_exec_name],
    }

    exec { $service_exec_name:
      command     => 'opensearch-dashboards systemctl daemon-reload',
      path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
      refreshonly => true,
      notify      => Service[$service_name],
    }

    service { $service_name:
      ensure  => running,
      enable  => true,
      require => File[$service_unit_name],
    }
  } elsif $opensearch_dashboards::ensure == 'absent'{

    service { $service_name:
      ensure => stopped,
      enable => false,
    }

    file { $service_unit_name:
      ensure => absent,
      notify => Exec[$clean_systemd],
    }

    exec { $clean_systemd:
      command     => 'opensearch-dashboards systemctl daemon-reload && systemctl reset-failed',
      path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
      refreshonly => true,
    }

  }

}
