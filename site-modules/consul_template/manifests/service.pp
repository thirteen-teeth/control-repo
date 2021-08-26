#comment
class consul_template::service {

  $unit_file         = 'consul-template.service'
  $systemd_dir       = '/etc/systemd/system'
  $service_unit_name = "${systemd_dir}/${unit_file}"
  $service_exec_name = 'consul-template-daemon-reload'
  $clean_systemd     = 'consul-template-clean-systemd'
  $service_name      = 'consul-template'

  if $ensure == 'present' {

    file { $service_unit_name:
      content => template("consul_template/${unit_file}.erb"),
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Class[$consul_template::config],
      notify  => Exec[$service_exec_name],
    }

    exec { $service_exec_name:
      command     => 'systemctl daemon-reload',
      path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
      refreshonly => true,
      notify      => Service[$$service_name],
    }

    service { $service_name:
      ensure  => running,
      enable  => true,
      require => File[$service_unit_name],
    }
  } elsif $ensure == 'absent'{

    service { $$service_name:
      ensure => stopped,
      enable => false,
    }

    file { $full_path:
      ensure => absent,
    }

    file { $install_dir:
      ensure => absent,
    }

    file { $service_unit_name:
      ensure => absent,
      notify => Exec[$clean_systemd],
    }

    exec { $clean_systemd:
      command     => 'systemctl daemon-reload && systemctl reset-failed',
      path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
      refreshonly => true,
    }

  }

}
