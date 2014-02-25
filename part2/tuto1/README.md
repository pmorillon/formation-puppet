# Part 2 : Puppet Master

## Tuto 1 : Master / Agent

On peut tout d'abord commencer par jeter un oeil sur le fichier `part2/Vagrantfile` :

* On définit 2 machines virtuelles, une pour le puppet master, l'autre pour un agent.
* On forward le port http sur le master pour l'utilisation de Puppet Dashboard.
* On ajoute un interface réseaux pour que ces 2 machines communiquent.
* On configure le provisionning via Puppet pour configurer le hostname et le `/etc/hosts` des VMS (`part2/manifests`).

### Démarrage des VMs

    $ cd part2
    $ vagrant up

### Installation et configuration du Puppet master

    $ vagrant ssh master

On peut tester la communication entre le master et l'agent :

    vagrant@master:~$ ping agent

#### Installation du paquet Debian

    vagrant@master:~$ sudo apt-get install puppetmaster=3.4.2-1puppetlabs1 puppetmaster-common=3.4.2-1puppetlabs1

On vérifie que le serveur tourne :

    vagrant@master:~$ ps -ef | grep puppet
    puppet    3060     1  0 17:33 ?        00:00:00 /usr/bin/ruby /usr/bin/puppet master --masterport=8140

#### Configuration du master

Par défaut le modulepath est `/etc/puppet/modules`. Par confort, on va le modifer pour utiliser `/vagrant/modules`.
Editer le fichier `/etc/puppet/puppet.conf` en utilisant l'option `modulepath=` dans la section `master`.

Redémarrer ensuite le master :

    vagrant@master:~$ sudo /etc/init.d/puppetmaster restart
    Restarting puppet master.


### Configuration de l'agent

    $ vagrant ssh agent

On Edit `/etc/puppet/puppet.conf`, on peut supprimer la section `master` (mauvais packaging), et on ajoute :

    [agent]
    server=master.vagrantup.com

#### Création d'un certificat et demande de signature

    vagrant@agent:~$ sudo puppet agent --test
    Info: Creating a new SSL key for agent.vagrantup.com
    Info: Caching certificate for ca
    Info: Creating a new SSL certificate request for agent.vagrantup.com
    Info: Certificate Request fingerprint (SHA256): E0:2B:FE:29:39:39:61:62:F3:3A:9E:8E:A6:C7:15:F4:83:C2:13:3C:5C:3D:24:45:BB:B5:60:CD:16:AF:32:60
    Exiting; no certificate found and waitforcert is disabled


#### Signature du certficat

On peut lister les demandes de signature :

    vagrant@master:~$ sudo puppet cert list
      agent.vagrantup.com  (SHA256) E0:2B:FE:29:39:39:61:62:F3:3A:9E:8E:A6:C7:15:F4:83:C2:13:3C:5C:3D:24:45:BB:B5:60:CD:16:AF:32:60

On signe le certificat :

    vagrant@master:~$ sudo puppet cert sign agent.vagrantup.com
      Signed certificate request for agent.vagrantup.com

#### Récupération du certificat signé

    vagrant@agent:~$ sudo puppet agent --test
    Info: Caching certificate for agent.vagrantup.com
    Info: Caching certificate_revocation_list for ca
    Info: Retrieving plugin
    Info: Caching catalog for agent.vagrantup.com
    Info: Applying configuration version '1357750855'
    Finished catalog run in 0.11 seconds

#### On peut vérifier sur le serveur les log

    vagrant@master:~$ sudo tail /var/log/syslog
    ...
    puppet-master[3233]: Compiled catalog for agent.vagrantup.com in environment production in 0.12 seconds

### Définition des nodes

On va définir quoi appliquer en fonction du noeud.

On utilise pour cela le fichier `/etc/puppet/manifests/site.pp` sur le Puppet Master :

    $ntp_servers = ['ntp1.irisa.fr', 'ntp2.irisa.fr']
    
    node 'agent.vagrantup.com' {
    
      class {
        'ntp':
          servers => $ntp_servers;
      }
    
    }

#### On test sur l'agent

    vagrant@agent:~$ sudo puppet agent --test



