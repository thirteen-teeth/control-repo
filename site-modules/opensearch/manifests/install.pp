#comment
class opensearch::install {

  $fix_permissions = 'install dir permissions fix'

  user { $opensearch::username:
    ensure => $opensearch::ensure,
    shell  => '/sbin/nologin',
  }

  File {
    owner => $opensearch::username,
    group => $opensearch::username,
  }
  file { $opensearch::log_dir:
    ensure => 'directory',
    mode   => '0750',
  }
  file { $opensearch::data_dir:
    ensure => 'directory',
    mode   => '0750',
  }


  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  archive { "${opensearch::download_target_dir}/${opensearch::artifact_name}":
    ensure       => $opensearch::ensure,
    extract      => true,
    extract_path => $opensearch::extract_dir,
    source       => $opensearch::artifact_full_url,
    creates      => $opensearch::install_dir,
    require      => User[$opensearch::username],
    notify       => Exec[$fix_permissions],
  }
  exec { $fix_permissions:
    command     => "chown -R ${opensearch::username}:${opensearch::username} ${opensearch::install_dir}",
    refreshonly => true,
  }

}
