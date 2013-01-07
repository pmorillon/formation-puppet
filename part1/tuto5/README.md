# Part 1 : DSL Puppet

## Tuto 5 : Vars, Facts and Templates

### Modifier le module _ntp_

Modifier le module `ntp` afin de pourvoir l'utiliser comme ceci dans `tuto5/manifests/init.pp` :

    $ntp_servers = ['ntp1.irisa.fr', 'ntp2.irisa.fr']
    
    class {
      'collectd':
        www     => true;
      'ntp':
        servers => $ntp_servers;
    }

__Notes__ :

* Utiliser le fichier `/etc/ntp.conf` de la machine virtuelle pour créer un template ERB.
* La partie du fichier qui sera modifié est la suivante :

      server 0.debian.pool.ntp.org iburst
      server 1.debian.pool.ntp.org iburst
      server 2.debian.pool.ntp.org iburst
      server 3.debian.pool.ntp.org iburst

* En ruby voici comment on parcourt sur un tableau :

      servers.each do |server|
        puts "server #{server} iburst"
      end


