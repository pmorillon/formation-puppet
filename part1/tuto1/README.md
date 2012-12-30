# Part 1 : DSL Puppet

## Tuto 1 : Resource File

### Création et gestion d'un fichier

Editer le fichier `manifests/init.pp` :

    file {
      '/tmp/test1':
        ensure  => file,
        mode    => 644, owner => root, group => root,
        content => 'test1\n';
    }

Sur le serveur via `vagrant ssh` :

    $ sudo puppet apply /vagrant/tuto1/manifests/init.pp

### Création et gestion d'un repertoire

Ajouter la resource :

    file {
      '/tmp/dir1':
        ensure  => directory,
        mode    => 755, owner => root, group => root;
    }

Sur le server :

    $ sudo puppet apply /vagrant/tuto1/manifests/init.pp

### Création d'un alias

    file {
      '/tmp/dir1/test2':
        ensure  => link,
        target  => '/tmp/test1';
    }

__Note__ : Dans le cas de la resource de type File, puppet arrive à gérer les dépendances pour nous, il réalise implicitement les relations :

    File['/tmp/test1'] -> File['/tmp/dir1/test2'] <- File['/tmp/dir1']

### Regroupement de resources par type

Il est possible de regrouper les resources par type comme ceci :

    file {
      '/tmp/test1':
        ensure  => file,
        mode    => 644, owner => root, group => root,
        content => 'test1\n';
      '/tmp/dir1':
        ensure  => directory,
        mode    => 755, owner => root, group => root;
      '/tmp/dir1/test2':
        ensure  => link,
        target  => '/tmp/test1';
    }


### Tests

Modifiez le contenu du fichier `/tmp/test1`, ainsi que les droits avec `chown`, puis lancez la commande suivante :

    $ sudo puppet apply --noop /vagrant/tuto1/manifests/init.pp
    
__Note__ : L'option `--noop` permet de n'appliquer aucun changement, mais de voir les changements à réaliser.

Enfin, rétablissez l'état souhaité :

    $ sudo puppet apply /vagrant/tuto1/manifests/init.pp
