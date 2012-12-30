# Part 1

## Tuto 1

### Création et gestion d'un fichier

Editer le fichier `manifests/init.pp` :

    file {
      '/tmp/test1':
        ensure  => file,
        mode    => 644, owner => root, group => root,
        content => 'test1\n';
    }

Sur le serveur via `vagrant ssh` :

    $ puppet apply /vagrant/part1/tuto1/manifests/init.pp

