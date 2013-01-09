host {
  'master.vagrantup.com':
    ensure        => present,
    host_aliases  => ['master'],
    ip            => '192.168.1.10';
  'agent.vagrantup.com':
    ensure        => present,
    host_aliases  => ['agent'],
    ip            => '192.168.1.11';
}

exec {
  'reconfigure hostname':
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    command     => '/etc/init.d/hostname.sh',
    refreshonly => true;
}

define hostname () {
  file {
    '/etc/hostname':
      ensure  => file,
      mode    => 644, owner => root, group => root,
      content => $name,
      notify  => Exec['reconfigure hostname'];
  }
}


