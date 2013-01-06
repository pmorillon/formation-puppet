# Part 1 : DSL Puppet

## Tuto 3 : Classes

Dans ce tuto, nous allons réorganiser en classes ce que nous avons réalisé au tuto 2.

### Abrorescence du projet

    .
    ├── README.md
    ├── files
    │   └── collection3.conf
    └── manifests
        ├── apache.pp
        ├── collectd
        │   └── www.pp
        ├── collectd.pp
        └── init.pp

### init.pp

# init.pp

    import "apache.pp"
    import "collectd.pp"
    import "collectd/www.pp"
    
    include collectd::www

### Création des classes

Créez maintenant les classes suivantes :

* `apache` dans le fichier _apache.pp_
* `collectd` dans le fichier _collectd.pp_
* `collectd::www` dans le fichier _collectd/www.pp_


