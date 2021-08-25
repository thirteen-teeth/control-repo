#comment
class consul_template::install {

  $fix_permissions = 'install dir permissions fix'
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  user { $consul_template::username:
    ensure => $consul_template::ensure,
    shell  => '/bin/bash',
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

  archive { "${consul_template::download_target_dir}/${consul_template::artifact_name}":
    ensure       => $consul_template::ensure,
    extract      => true,
    extract_path => $consul_template::extract_dir,
    source       => $consul_template::artifact_full_url,
    creates      => $consul_template::install_dir,
    require      => User[$consul_template::username],
    notify       => Exec[$fix_permissions],
  }
  exec { $fix_permissions:
    command     => "chown -R ${consul_template::username}:${consul_template::username} ${consul_template::install_dir}",
    refreshonly => true,
  }

}
