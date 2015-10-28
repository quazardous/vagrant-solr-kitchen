## Vagrant SolR 5 Kitchen

A simple Centos65-x64 based SolR box. The main provision part is in **bash**.

Master branch documentation is for SolR 5.

## Installation

Clone GIT and vagrant up:

    git clone git@github.com:quazardous/vagrant-solr-kitchen.git
    vagrant up

NB: A **solr** folder will appear in the project wich is symlinked in the box.

## SolR Version

### Branch master

SolR version : 5.3.1

### Branch solr-4.x

SolR version : 4.10.2

## Usage

### SolR admin

By default the SolR port is mapped to the host :

http://localhost:8983/solr/

You can change it in the params.yml file.

### SolR data and conf integration

The SolR data folder is mounted from the local ./solr folder to the remote /vagrant/solr/data folder.
The install process creates a foo core in ./solr/foo.

### Create a core

#### From terminal

Log in the vm (with vagrant ssh) and :

    sudo runuser -l solr -c "/opt/solr/bin/solr create -c new_core"

NB : **do not** use the solr create command with the root user.

#### From IDE and Core Admin

Copy the ./solr/foo/conf folder into a new ./solr/new_core/conf folder.

Use the Core Admin > Add Core button.

## Troubleshooting

### Service statup

For now you need to (re)start solr service each time you up.

    vagrant ssh -c 'sudo service solr restart'

-> http://razius.com/articles/launching-services-after-vagrant-mount/

So after install you have to up you box with:

    vagrant up && vagrant ssh -c 'sudo service solr restart'

## License

MIT
