#comment
class profile::logstash (
  $repo_name = 'elastic-oss-7',
  $package_name = 'logstash-oss',
  $version = '7.10.2',
) {

  yumrepo { $repo_name:
    enabled  => 1,
    descr    => $repo_name,
    baseurl  => 'https://artifacts.elastic.co/packages/oss-7.x/yum',
    gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
    gpgcheck => 1,
  }

  $plugin_exec = 'logstash_exec'

  package { $package_name:
    ensure  => $version,
    require => Yumrepo[$repo_name],
    notify  => Exec[$plugin_exec],
  }

  exec { $plugin_exec:
    command => '/usr/share/logstash/bin/logstash-plugin install logstash-output-opensearch',
    # unless  => "curl -sS -XGET 'localhost:9600/_node/plugins' | jq '.plugins[] | \
    # select(.name==\"logstash-output-opensearch\")' | grep logstash-output-opensearch",
    # would only work if logstash systemd process is running, check quotes escaping
    unless  => '/usr/share/logstash/bin/logstash-plugin list | grep logstash-output-opensearch',
  }

  file { 'pipeline-opensearch.conf':
    path    => '/etc/logstash/conf.d/pipeline-opensearch.conf',
    mode    => '0644',
    owner   => 'logstash',
    group   => 'logstash',
    content => template('profile/logstash/pipeline-opensearch.conf.erb'),
    require => Package[$package_name],
  }

  file { 'nginx.log':
    path    => '/tmp/nginx.log',
    mode    => '0644',
    owner   => 'logstash',
    group   => 'logstash',
    source  => 'puppet:///modules/profile/nginx.log',
    require => Package[$package_name],
  }

}
