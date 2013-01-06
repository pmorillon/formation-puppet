# collectd/www.pp

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
      source  => '/vagrant/tuto3/files/collection3.conf',
      require => Package['apache2'],
      notify  => Service['apache2'];
  }

} # Class:: collectd::www
