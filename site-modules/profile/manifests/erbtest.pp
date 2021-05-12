#A basic profile for testing ERB's using Hiera data

class profile::erbtest (
  $data = undef,
) {

  file { '/tmp/erb':
    content => template('profile/erbtest/template.erb'),
  }

}
