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

  package { 'logstash-oss':
    ensure  => '7.10.2',
    require => Yumrepo[$repo_name],
  }

}
