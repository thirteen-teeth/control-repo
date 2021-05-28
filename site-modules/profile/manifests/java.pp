# a basic class for installing java

class profile::java {

  class { 'java':
    package => 'java-11-openjdk',
  }

}
