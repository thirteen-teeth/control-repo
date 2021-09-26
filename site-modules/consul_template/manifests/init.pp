#comment
class consul_template (
  String         $version,
  String         $ensure,
  String         $artifact_base_url,
  String         $artifact_name,
  String         $artifact_full_url,
  String         $download_target_dir,
  String         $bin,
  String         $install_dir,
  Boolean        $manage_user,
  Boolean        $manage_systemd,
  String         $username,
  String         $config_dir,
  String         $log_dir,
  String         $data_dir,
  Hash           $general,
  Hash           $consul,
  Hash           $vault,
  Optional[Hash] $templates,
) {
  contain consul_template::install
  contain consul_template::config
  contain consul_template::service

  Class['consul_template::install'] ~> Class['consul_template::config'] ~> Class['consul_template::service']
}
