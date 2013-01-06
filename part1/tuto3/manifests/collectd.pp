# collectd.pp

import 'apache.pp'
import 'collectd/www.pp'

# Class:: collectd
#
#
class collectd ($www = false) {

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

  if $www == true {
    include 'collectd::www'
  }

} # Class:: collectd
