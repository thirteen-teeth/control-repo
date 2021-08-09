#comment
class opensearch::config {

  $config_hash = $opensearch::config_hash

  file { '/tmp/outfile':
    content => $config_hash
  }

  if $opensearch::ensure == 'present' {
    $managed_files = ['opensearch.yml']
    $managed_files.each | String $filename | {
      file { "${opensearch::config_dir}/${filename}":
        ensure  => present,
        mode    => '0640',
        content => template("opensearch/${filename}.erb"),
      }
    }
  }

}
