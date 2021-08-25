#comment
class consul_template::install {

  $fix_permissions = 'consul_template dir permissions fix'
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  user { $consul_template::username:
    ensure => $consul_template::ensure,
    shell  => '/bin/bash', #FIX ME
  }

  File {
    owner => $consul_template::username,
    group => $consul_template::username,
  }
  file { $consul_template::log_dir:
    ensure => 'directory',
    mode   => '0750',
  }
  file { $consul_template::data_dir:
    ensure => 'directory',
    mode   => '0750',
  }
  file { $consul_template::install_dir:
    ensure => 'directory',
    mode   => '0750',
  }

  archive { "${consul_template::install_dir}/consul-template_0.27.0_linux_amd64.zip":
    ensure       => present,
    source       => 'https://releases.hashicorp.com/consul-template/0.27.0/consul-template_0.27.0_linux_amd64.zip',
    extract      => true,
    extract_path => $consul_template::install_dir,
#    creates      => "${consul_template::install_dir}/${consul_template::bin}",
    require      => [ User[$consul_template::username],
                      File[$consul_template::install_dir]
                    ],
    notify       => Exec[$fix_permissions],
  }
  exec { $fix_permissions:
    command     => "chown -R ${consul_template::username}:${consul_template::username} ${consul_template::install_dir}",
    refreshonly => true,
  }

  file { '/tmp/test':
    content => "${consul_template::install_dir}/${consul_template::bin}",
  }

}
