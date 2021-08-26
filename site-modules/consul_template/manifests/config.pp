#comment
class consul_template::config {

  $config_file = 'config.hcl'
  $config_dir = $consul_template::config_dir

  file { "${config_dir}/${config_file}":
    ensure  => $consul_template::ensure,
    mode    => '0750',
    owner   => $consul_template::username,
    group   => $consul_template::username,
    content => template("consul_template/${config_file}.erb"),
  }


}
