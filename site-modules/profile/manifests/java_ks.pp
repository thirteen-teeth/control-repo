#comment
class profile::java_ks (
  String $path       = '/usr/lib/jvm/jre/bin',
  String $truststore = '/opt/truststore.jks',
  String $keystore   = '/opt/keystore.jks',
  String $password   = 'strongpassword', #TODO: SECRET
  String $ssldir     = $facts['puppet_ssldir'],
) {

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
    ensure       => latest,
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
