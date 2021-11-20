#comment
class opensearch (
  String  $version,
  String  $ensure,
  String  $artifact_base_url,
  String  $artifact_name,
  String  $artifact_full_url,
  String  $download_target_dir,
  String  $extract_dir,
  String  $install_dir,
  Boolean $manage_user,
  Boolean $manage_systemd,
  String  $username,
  String  $config_dir,
  String  $log_dir,
  String  $data_dir,
  Hash    $config_hash,
  Hash    $plugins_hash,
) {
#  contain opensearch::install
#  contain opensearch::config
#  contain opensearch::plugins
#  contain opensearch::service
#  Class['opensearch::install'] ~> Class['opensearch::config'] ~> Class['opensearch::plugins'] ~> Class['opensearch::service']

  contain opensearch::install
  contain opensearch::config
  contain opensearch::service
  Class['opensearch::install'] ~> Class['opensearch::config'] ~> Class['opensearch::service']


}
