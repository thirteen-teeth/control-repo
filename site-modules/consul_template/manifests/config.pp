#comment
class consul_template::config {

  $config_file = 'config.hcl'
  $config_dir = $consul_template::config_dir
  $config_file_name = "${config_dir}/${config_file}"

  File {
    owner => $consul_template::username,
    group => $consul_template::username,
  }

  file { $config_dir:
    ensure => directory,
    mode   => '0750',
  }

  file { $config_file_name:
    mode    => '0640',
    content => template("consul_template/${config_file}.erb"),
    require => File[$config_dir],
  }

}
