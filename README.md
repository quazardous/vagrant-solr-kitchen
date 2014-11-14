## Vagrant SolR Kitchen

A simple Centos65-x64 based SolR box. The main provision part is in **bash** and it's Puppet enabled.

## Installation

Clone GIT and vagrant up.

## SolR

Tested SolR version : 4.10.2

A **solr** folder will appear in the project wich is symlinked in the box.

http://localhost:8983/solr/


## Troubleshooting

### Service statup

For now you need to restart solr service each time you up.

    service solr restart

-> http://razius.com/articles/launching-services-after-vagrant-mount/

So full install is :

    vagrant up && vagrant ssh -c 'sudo service solr restart'

### SolR contrib

The box inject the correct **solr.contrib.dir** so you may check your **solrcore.properties** file and not override this property.

## License

MIT
