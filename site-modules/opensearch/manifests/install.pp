#comment
class opensearch::install {

  $fix_permissions = 'install dir permissions fix'

  user { $opensearch::username:
    ensure     => $opensearch::ensure,
    shell      => '/sbin/nologin',
    managehome => true,
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
    path        => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    refreshonly => true,
  }

  file_line { 'opensearch soft':
    path => '/etc/security/limits.conf',
    line => 'opensearch soft memlock unlimited',
  }

  file_line { 'opensearch hard':
    path => '/etc/security/limits.conf',
    line => 'opensearch hard memlock unlimited',
  }

  sysctl { 'vm.max_map_count': value => '262144' }

}

#openssl x509 -subject -nameopt RFC2253 -noout -in
