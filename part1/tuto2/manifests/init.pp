package {
  ['apache2','collectd']:
    ensure => installed;
}

package {
  ['libconfig-general-perl', 'librrds-perl', 'libregexp-common-perl', 'libhtml-parser-perl']:
    ensure => installed;
}

service {
  ['apache2', 'collectd']:
    ensure => running,
    enable => true;
}

file {
  '/etc/apache2/conf.d/collection3.conf':
      ensure  => file,
      mode    => 644, owner => root, group => root,
      source  => '/vagrant/tuto2/files/collection3.conf',
}

Package['apache2'] -> File['/etc/apache2/conf.d/collection3.conf'] ~> Service['apache2']
Package['collectd'] -> Service['collectd']
