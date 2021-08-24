#comment
class profile::java_ks (
  String $path       = '/usr/lib/jvm/jre/bin',
  String $truststore = '/opt/opensearch-1.0.0/config/ssl/truststore.jks',
  String $keystore   = '/opt/opensearch-1.0.0/config/ssl/keystore.jks',
  String $password   = 'strongpassword', #TODO: SECRET
  String $ssldir     = '/etc/puppetlabs/puppet/ssl',
) {

  include profile::java

  Java_ks {
    ensure   => latest,
    password => $password,
    path     => $path,
    require  => Class['profile::java']
  }

  java_ks { 'puppetca:truststore':
    certificate  => "${ssldir}/certs/ca.pem",
    target       => $truststore,
    trustcacerts => true,
  }

  java_ks { 'puppetca:keystore':
    certificate  => "${ssldir}/certs/ca.pem",
    target       => $keystore,
    trustcacerts => true,
  }

  java_ks { "${::fqdn}:${keystore}":
    certificate         => "${ssldir}/certs/${::fqdn}.pem",
    private_key         => "${ssldir}/private_keys/${::fqdn}.pem",
    password_fail_reset => true,
  }

}
