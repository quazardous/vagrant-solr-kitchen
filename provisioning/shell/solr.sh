#!/usr/bin/env bash
# from http://www.erikwebb.net/blog/installing-apache-solr-jetty-rhel-6/
version=5.3.1
tarurl=http://apache.crihan.fr/dist/lucene/solr/$version/solr-$version.tgz
solrbase=/opt/solr
solrconf=multicore
vagrantproject=/vagrant
vagrantgroup=vagrant
solruser=solr
solrgroup=solr

restart=
if [[ ! -d $solrbase ]];then
	service solr stop 2>/dev/null
	
(
	echo "SolR install..."
	cd /tmp
	mkdir -p solr-install
	cd solr-install
	if [[ ! -f solr-$version.tgz ]];then
		if ! curl -s -O $tarurl;then
			echo "Cannot download $tarurl"
			exit 9
		fi
	fi
	rm -rf work
	mkdir work
	tar xzf solr-$version.tgz -C work

	# install SolR
	work/solr-$version/bin/install_solr_service.sh solr-$version.tgz
	usermod -G $vagrantgroup $solruser
	# chkconfig --add solr

	rm -rf work

	echo "SolR installed"
)
	
fi

if [[ ! -d $vagrantproject/solr ]];then
	service solr stop
	mv /var/solr/data $vagrantproject/solr
(
	cd /var/solr
	ln -snf $vagrantproject/solr data
)
	service solr start
	runuser -l solr -c "/opt/solr/bin/solr create -c foo"
fi






