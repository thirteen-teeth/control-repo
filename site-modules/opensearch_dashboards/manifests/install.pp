#comment
class opensearch_dashboards::install {

  $fix_permissions = 'opensearch-dashboards install dir permissions fix'
  $copy_certs = 'copy puppet certs'
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  user { $opensearch_dashboards::username:
    ensure     => $opensearch_dashboards::ensure,
    shell      => '/bin/bash', #FIX ME
    managehome => true,
  }

  File {
    owner => $opensearch_dashboards::username,
    group => $opensearch_dashboards::username,
  }
  file { $opensearch_dashboards::log_dir:
    ensure => 'directory',
    mode   => '0750',
  }
  file { $opensearch_dashboards::data_dir:
    ensure => 'directory',
    mode   => '0750',
  }

  archive { "${opensearch_dashboards::download_target_dir}/${opensearch_dashboards::artifact_name}":
    ensure       => $opensearch_dashboards::ensure,
    extract      => true,
    extract_path => $opensearch_dashboards::extract_dir,
    source       => $opensearch_dashboards::artifact_full_url,
    creates      => $opensearch_dashboards::install_dir,
    require      => User[$opensearch_dashboards::username],
    notify       => Exec[$fix_permissions],
  }
  exec { $fix_permissions:
    command     => "chown -R ${opensearch_dashboards::username}:${opensearch_dashboards::username} ${opensearch_dashboards::install_dir}",
    refreshonly => true,
  }

  file_line { 'opensearch soft':
    path => '/etc/security/limits.conf',
    line => 'opensearch-dashboards soft memlock unlimited',
  }

  file_line { 'opensearch hard':
    path => '/etc/security/limits.conf',
    line => 'opensearch-dashboards hard memlock unlimited',
  }

  sysctl { 'vm.max_map_count': value => '262144' }

}
