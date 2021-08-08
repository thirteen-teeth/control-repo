#comment
class opensearch::install {

  user { $opensearch::username:
    ensure => $opensearch::ensure,
    shell  => '/sbin/nologin',
  }

  #set defaults 
  File {
    user  => $opensearch::username,
    group => $opensearch::username,
  }


  archive { "${opensearch::download_target_dir}/${opensearch::artifact_name}":
    ensure       => $opensearch::ensure,
    extract      => true,
    extract_path => $opensearch::extract_dir,
    source       => $opensearch::artifact_full_url,
    creates      => $opensearch::install_dir,
    user         => $opensearch::username,
    group        => $opensearch::username,
    require      => User[$opensearch::username],
  }

  file { $opensearch::install_dir:
    ensure => directory,
    mode   => '0755',
  }

}
