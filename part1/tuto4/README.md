# Part 1 : DSL Puppet

## Tuto 4 : Modules


### Manifest _init.pp_

Le fichier `tuto4/manifests/init.pp` contiendra :

    include 'ntp'
    
    class {
      'collectd':
        www => true;
    }


### Creation des modules

Créez les 3 modules suivants en utilisant tant que possible l'autoload :

* apache
* collectd
* ntp

__Note__ : Pour le module _ntp_, On ne gèrera pour l'instant pas le contenu du fichier `/etc/ntp.conf`.

### Utilisation des modules avec _puppet apply_

Ajouter l'option `--modulepath`

    $ sudo puppet apply --modulepath=/vagrant/tuto4/modules/ /vagrant/tuto4/manifests/init.pp

__Note__ : Il est possible de définir le `modulepath` en éditant le fichier `/etc/puppet/puppet.conf` en ajoutant la ligne suivante dans la section `[main]`

    modulepath=/vagrant/tuto4/modules/


