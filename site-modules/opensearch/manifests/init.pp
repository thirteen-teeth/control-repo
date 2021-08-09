#comment
class opensearch (
  String $version = '1.0.0',
  String $ensure = 'present',
  String $artifact_base_url = 'https://artifacts.opensearch.org/releases/bundle/opensearch',
  String $artifact_name = "opensearch-${version}-linux-x64.tar.gz",
  String $artifact_full_url = "${artifact_base_url}/${version}/opensearch-${version}-linux-x64.tar.gz",
  String $download_target_dir = '/opt',
  String $extract_dir = '/opt',
  String $install_dir = "${extract_dir}/opensearch-${version}",
  Boolean $manage_user = true,
  Boolean $manage_systemd = true,
  String $username = 'opensearch',
  String $config_dir = "${install_dir}/config",
  String $log_dir = '/var/log/opensearch',
  String $data_dir = '/var/lib/opensearch',
  Hash $config_hash = {},
) {
  contain opensearch::install
  contain opensearch::config

  Class['opensearch::install'] ~> Class['opensearch::config']
}
