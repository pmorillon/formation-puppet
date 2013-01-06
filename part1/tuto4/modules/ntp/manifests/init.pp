# Module:: ntp
# Manifest:: init.pp
#

# Class:: ntp
#
#
class ntp {

  package {
    'ntp':
      ensure => installed;
  }

  service {
    'ntp':
      ensure  => running,
      enable  => true;
  }

  file {
    '/etc/ntp.conf':
      ensure  => file,
      mode    => 644, owner => root, group => root;
  }

  Package['ntp'] -> File['/etc/ntp.conf'] ~> Service['ntp']

} # Class:: ntp
