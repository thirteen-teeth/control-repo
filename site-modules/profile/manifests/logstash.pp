#comment
class profile::logstash (
  $repo_name = 'elastic-oss-7',
) {

  yumrepo { $repo_name:
    enabled  => 1,
    descr    => $repo_name,
    baseurl  => 'https://artifacts.elastic.co/packages/oss-7.x/yum',
    gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
    gpgcheck => 1,
  }

  $plugin_exec = 'logstash_exec'

  package { 'logstash-oss':
    ensure  => '7.10.2',
    require => Yumrepo[$repo_name],
    notify  => Exec[$plugin_exec],
  }

  exec { $plugin_exec:
    command     => '/usr/share/logstash/bin/logstash-plugin install logstash-output-opensearch',
    refreshonly => true,
    # unless works really slow because it checks every time, find a better way, 3s -> 12s puppet run
    # unless  => '/usr/share/logstash/bin/logstash-plugin list | grep logstash-output-opensearch',
  }

}
