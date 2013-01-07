$ntp_servers = ['ntp1.irisa.fr', 'ntp2.irisa.fr']

class {
  'collectd':
    www     => true;
  'ntp':
    servers => $ntp_servers;
}

