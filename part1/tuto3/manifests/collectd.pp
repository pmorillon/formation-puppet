# collectd.pp

# Class:: collectd
#
#
class collectd {

  package {
    'collectd':
      ensure => installed;
  }

  service {
    'collectd':
      ensure => running,
      enable => true;
  }

  Package['collectd'] -> Service['collectd']

} # Class:: collectd
