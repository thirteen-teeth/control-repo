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
) {
  include opensearch::install
}
