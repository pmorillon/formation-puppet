# Part 1 : DSL Puppet

## Tuto 3 : Modules


### Manifest _init.pp_

La fichier `tuto4/manifests/init.pp` contiendra :

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

__Note__ : Pour le module _ntp_, On ne gèrera pour l'instant pas le contenu du fichier `/etc/ntp.conf`, on s'assurera seulement des droits et que tout changement relance le serveur _ntp_.


