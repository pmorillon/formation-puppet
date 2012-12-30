# Part 1

## Tuto 1

Editer le fichier `manifests/init.pp` :

    file {
      '/tmp/test1':
        ensure  => file,
        mode    => 644, owner => root, group => root,
        content => 'test1\n';
    }

