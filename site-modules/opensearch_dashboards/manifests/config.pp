#comment
class opensearch_dashboards::config {

  $config_hash = $opensearch_dashboards::config_hash

  if $opensearch_dashboards::ensure == 'present' {
    $managed_files = ['opensearch_dashboards.yml']
    $managed_files.each | String $filename | {
      file { "${opensearch_dashboards::config_dir}/${filename}":
        ensure  => present,
        mode    => '0640',
        content => template("opensearch_dashboards/${filename}.erb"),
      }
    }
  }

}
