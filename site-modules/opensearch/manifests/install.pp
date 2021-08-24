#comment
class opensearch::install {

  $fix_permissions = 'install dir permissions fix'
  $copy_certs = 'copy puppet certs'
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  user { $opensearch::username:
    ensure => $opensearch::ensure,
    shell  => '/bin/bash',
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
    notify       => Exec[$copy_certs],
  }

  sysctl { 'vm.max_map_count':
    ensure => present,
    value  => '262144',
  }

  file_line { 'opensearch soft':
    path => '/etc/security/limits.conf',
    line => 'opensearch soft memlock unlimited',
  }

  file_line { 'opensearch hard':
    path => '/etc/security/limits.conf',
    line => 'opensearch hard memlock unlimited',
  }

}

#openssl x509 -subject -nameopt RFC2253 -noout -in
