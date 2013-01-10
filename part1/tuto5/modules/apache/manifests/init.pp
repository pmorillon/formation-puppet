# Module:: apache
# Manifest:: init.pp
#


# Class:: apache
#
#
class apache {

  package {
    'apache2':
      ensure  => installed,
      name    => $operatingsystem ? {
        Debian => 'apache2',
        Centos => 'httpd',
      };
  }

  service {
    'apache2':
      ensure  => running,
      enable  => true,
      name    => $operatingsystem ? {
        Debian => 'apache2',
        Centos => 'httpd',
      };
  }

  Package['apache2'] -> Service['apache2']

} # Class:: apache
