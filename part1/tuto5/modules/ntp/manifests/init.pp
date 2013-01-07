# Module:: ntp
# Manifest:: init.pp
#

# Class:: ntp
#
#
class ntp ($servers = ['0.debian.pool.ntp.org']) {

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
      mode    => 644, owner => root, group => root,
      content => template('ntp/ntp.conf.erb');
  }

  Package['ntp'] -> File['/etc/ntp.conf'] ~> Service['ntp']

} # Class:: ntp
