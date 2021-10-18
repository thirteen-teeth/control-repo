#comment
class opensearch_dashboards (
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
) {
  contain opensearch_dashboards::install
  contain opensearch_dashboards::config
  contain opensearch_dashboards::service

  Class['opensearch_dashboards::install'] ~> Class['opensearch_dashboards::config'] ~> Class['opensearch_dashboards::service']
}
