# Part 2 : Puppet Master

## Tuto 3 : Hiera

On commencera par éditer le fichier `/etc/puppet/puppet.conf` pour ne plus utiliser Puppet Dashboard comme ENC au niveau du puppet master.

### Test de Hiera

Créer le fichier `/var/lib/hiera/global.yaml`

    ---
    ntp_servers:
     - ntp1.irisa.fr
     - ntp2.irisa.fr

Test avec l'option `--debug` pour voir le fonctionnement :

    vagrant@master:~$ hiera ntp_servers --debug

### Configurer Puppet pour utiliser Hiera

    vagrant@master:~$ sudo ln -s /etc/hiera.yaml /etc/puppet/hiera.yaml

Editer le fichier `/etc/puppet/manifests/site.pp` :

    $ntp_servers = hiera_array('ntp_servers')

Tester puppet sur l'agent.

### Utiliser Hiera comme External Node Classifier

Editer le fichier `/etc/puppet/manifests/site.pp` en ne laissant que la ligne suivante :

    hiera_include('classes')

Ajouter le fichier `/var/lib/hiera/agent.vagrantup.com.yaml`

    ---
    classes:
     - ntp
    ntp::servers:
     - ntp1.irisa.fr
     - ntp2.irisa.fr

Relancer l'agent.
