# Module:: collectd
# Manifest:: www.pp
#

# Class:: collectd::www
#
#
class collectd::www {

  include 'apache'
  include 'collectd'

  file {
    '/etc/apache2/conf.d/collection3.conf':
      ensure  => file,
      mode    => 644, owner => root, group => root,
      source  => 'puppet:///modules/collectd/collection3.conf',
      require => Package['apache2'],
      notify  => Service['apache2'];
  }

  package {
    ['libconfig-general-perl', 'librrds-perl', 'libregexp-common-perl', 'libhtml-parser-perl']:
    ensure => installed;
  }


} # Class:: collectd::www
