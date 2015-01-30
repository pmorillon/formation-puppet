# Part 2 : Puppet Master

## Tuto 2 : Puppet Dashboard

### Installation et configuration de Puppet Dashboard

    vagrant@master:~$ sudo apt-get install puppet-dashboard=1.2.23-1puppetlabs1

Editer le fichier `/etc/default/puppet-dashboard` et décommenter `START=yes`.

    vagrant@master:~$ sudo /etc/init.d/puppet-dashboard start

Installer un serveur Mysql :

    vagrant@master:~$ sudo apt-get install mysql-server

Création de la base de données :

    vagrant@master:~$ sudo mysql -u root
    mysql> CREATE DATABASE dashboard CHARACTER SET utf8;
    mysql> CREATE USER 'dashboard'@'localhost' IDENTIFIED BY 'pass';
    mysql> GRANT ALL PRIVILEGES ON dashboard.* TO 'dashboard'@'localhost';


Editer `/usr/share/puppet-dashboard/config/database.yml`

    production:
      database: dashboard
      username: dashboard
      password: pass
      encoding: utf8
      adapter: mysql


    vagrant@master:~$ cd /usr/share/puppet-dashboard
    vagrant@master:/usr/share/puppet-dashboard$ sudo rake RAILS_ENV=production db:migrate

Démarrer le service

    vagrant@master:~$ sudo /etc/init.d/puppet-dashboard start

Tester le service : [http://localhost:3000](http://localhost:3000)

__Notes__ : Plus d'informations sur [http://docs.puppetlabs.com/dashboard/manual/1.2/bootstrapping.html#configuring-dashboard](http://docs.puppetlabs.com/dashboard/manual/1.2/bootstrapping.html#configuring-dashboard)


### Configurer le puppet master

Editer le fichier `/etc/puppet/puppet.conf`

    # Reports -> Puppet Dashboard
    reports=http
    reporturl=http://localhost:3000/reports/upload
    # ENC -> Puppet Dashboard
    node_terminus = exec
    external_nodes = /usr/bin/env PUPPET_DASHBOARD_URL=http://localhost:3000 /usr/share/puppet-dashboard/bin/external_node

Redémarrer les services
    
    vagrant@master:~$ sudo /etc/init.d/puppetmaster restart
    vagrant@master:~$ sudo /etc/init.d/puppet-dashboard-workers restart
    
Relancer l'agent

    vagrant@agent:~$ sudo puppet agent --test

Ajouter la classe `apache` et le noeud `agent.vagrantup.com` dans le dashboard, puis tester l'ENC via la ligne de commande.

    vagrant@master:~$ /usr/bin/env PUPPET_DASHBOARD_URL=http://localhost:3000 /usr/share/puppet-dashboard/bin/external_node agent.vagrantup.com
    ---
    name: agent.vagrantup.com
    classes:
    - apache
    parameters: {}

Lancer puppet sur le noeud.

    vagrant@agent:~$ sudo puppet agent -t
    Info: Retrieving plugin
    Info: Caching catalog for agent.vagrantup.com
    Info: Applying configuration version '1393344474'
    Error: Could not prefetch package provider 'apt': invalid byte sequence in US-ASCII
    Notice: /Stage[main]/Apache/Package[apache2]/ensure: ensure changed 'purged' to 'present'
    Notice: Finished catalog run in 11.20 seconds


