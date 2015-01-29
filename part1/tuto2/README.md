# Part 1 : DSL Puppet

## Tuto 2 : Relations

Dans ce tutoriel nous allons installer collectd et activer l'interface web de collectd.

### Packages

#### Installation de collectd

    package {
      'collectd':
        ensure => installed;
    }

#### Installation de apache

    package {
      'apache2':
        ensure => installed;
    }


#### Installation des dépendances pour l'interface web

    package {
      ['libconfig-general-perl', 'librrds-perl', 'libregexp-common-perl', 'libhtml-parser-perl']:
        ensure => installed;
    }

### Services

#### Collectd

    service {
      'collectd':
        ensure => running,
        enable => true;
    }

#### Apache

    service {
      'apache2':
        ensure => running,
        enable => true;
    }

### Fichier de configuration Apache

    file {
      '/etc/apache2/conf.d/collection3.conf':
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        source  => '/vagrant/tuto2/files/collection3.conf',
    }

### Puppet apply

Dans l'état actuel du manifest, la commande suivant va générer des erreurs :

    $ sudo puppet apply /vagrant/tuto2/manifests/init.pp

### Définition des relations

* Définissez les relations nécessaires à l'aide des metaparamètres.
* Factoriser ensuite le manifest à l'aide des flèches de relations.

### Vérifier le résultat

Ouvrir l'URL suivante dans votre naigateur : [http://localhost:10080/collectd/](http://localhost:10080/collectd/)

