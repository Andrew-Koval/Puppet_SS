# === Class: profiles::subversion_server
#
#  Profile for deploying of Subversion Server
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
# None
#
# === Authors
#
# Andriy Koval <akova@softserveinc.com>
#
# === Copyright
#
# Copyright 2017 Andriy Koval
#

class profiles::subversion_server {

  class { 'subversion::svn':
    before => Class['subversion::svn_configs'],
  }

  class { 'subversion::svn_configs':
    require => Class['subversion::svn'],
  }

  subversion::repo { 'repo1':
    repo_name => ['repo1'],
    require   => Class['subversion::svn'],
  }

  subversion::repo { 'repo2':
    repo_name => ['repo2'],
    require   => Class['subversion::svn'],
  }

  subversion::repo { 'repo3':
    repo_name => ['repo3'],
    require   => Class['subversion::svn'],
  }

  class { 'subversion::svn_admin':
    require => Class['subversion::svn_configs'],
  }

  subversion::svn_users { 'user1':
    svn_user      => ['vboyko'],
    user_password => ['$apr1$c6X7DJt5$vC.bFrCWMakK/uVhVcOv.1'],
    require       => Class['subversion::svn_admin'],
  }

  subversion::svn_users { 'user2':
    svn_user      => ['user2'],
    user_password => ['$apr1$S6xarDGG$5u4Vd19AQqcMMsoN0RAu1/'],
    require       => Class['subversion::svn_admin'],
  }

  subversion::svn_users { 'user3':
    svn_user      => ['user3'],
    user_password => ['$apr1$hTXfYtvx$vmlhfpH8KOU1UMIU.pX/J1'],
    require       => Class['subversion::svn_admin'],
  }

  class { 'https':
    require => Class['subversion::svn_admin'],
    before  => Class['httpd'],
  }

  class { 'httpd':
    require => Class['https'],
  }
}
