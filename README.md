## Vagrant SolR Kitchen

A simple Centos65-x64 based SolR box. The main provision part is in **bash** and it's Puppet enabled.

## Installation

Clone GIT and vagrant up:

    git clone git@github.com:quazardous/vagrant-solr-kitchen.git
    vagrant up

NB: A **solr** folder will appear in the project wich is symlinked in the box.

## SolR

SolR version : 4.10.2

## Usage

### SolR admin

By default the SolR port is mapped the host :

http://localhost:8983/solr/

### SolR conf

the SolR conf is available in the **./solr/multicore/** folder.

Steps :

1. Edit/copy the conf
2. restart solr service

From host :

    vagrant ssh -c 'sudo service solr restart'

## Troubleshooting

### Service statup

For now you need to restart solr service each time you up.

    vagrant ssh -c 'sudo service solr restart'

-> http://razius.com/articles/launching-services-after-vagrant-mount/

So after install you have to up you box with:

    vagrant up && vagrant ssh -c 'sudo service solr restart'

### SolR contrib

The box inject the correct **solr.contrib.dir** so you may check your **solrcore.properties** file and not override this property.

## License

MIT
