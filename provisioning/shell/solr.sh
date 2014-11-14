#!/usr/bin/env bash
# from http://www.erikwebb.net/blog/installing-apache-solr-jetty-rhel-6/
version=4.10.2
tarurl=http://www.eu.apache.org/dist/lucene/solr/$version/solr-$version.tgz
initshurl=http://dev.eclipse.org/svnroot/rt/org.eclipse.jetty/jetty/trunk/jetty-distribution/src/main/resources/bin/jetty.sh
solrbase=/opt/solr
# existing default web solr distrib
distrib=example
# choose initial conf from example
#solrconf=solr
solrconf=multicore
vagrantproject=/vagrant
solrprojectconf=solr
vagrantgroup=vagrant
solruser=solr
solrgroup=solr

restart=
if [[ ! -d $solrbase ]];then
	service solr stop 2>/dev/null
	useradd -r -d $solrbase/$distrib -M -c "Apache Solr" $solruser -G $vagrantgroup
	usermod -d $solrbase/$distrib -G $vagrantgroup $solruser
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
	if [[ ! -d $solrbase ]];then
		# install SolR
		cp -r work/solr-$version $solrbase
		if [[ ! -d $solrbase/$distrib ]];then
			cp -pr $solrbase/example $solrbase/$distrib
		fi
		rm -rf $solrbase/$distrib/$solrconf
		chown -R $solruser:$solrgroup $solrbase/$distrib
	fi
	if [[ ! -d $vagrantproject/$solrprojectconf ]];then
		# initialize default solr conf in project
		mkdir -p $vagrantproject/$solrprojectconf
		cp -r work/solr-$version/example/$solrconf $vagrantproject/$solrprojectconf
		echo "SolR conf is available in your project in $solrprojectconf/$solrconf"
	fi
	
	ln -snf $vagrantproject/$solrprojectconf/$solrconf $solrbase/$distrib/$solrconf
	rm -rf work

	echo "SolR installed in $solrbase/$distrib"
)
	restart=1
fi

if [[ ! -f /etc/sysconfig/solr ]];then
	cat <<EOF > /etc/sysconfig/solr
JAVA_HOME=/usr/java/default
JAVA_OPTIONS="-Dsolr.solr.home=$solrbase/$distrib/$solrconf -Dsolr.contrib.dir=$solrbase/contrib $JAVA_OPTIONS"
JETTY_HOME=$solrbase/$distrib
JETTY_USER=$solruser
JETTY_LOGS=$solrbase/$distrib/logs	
EOF
	restart=1
fi

if [[ ! -f /etc/init.d/solr ]];then
	# Download the Jetty default startup script
	curl -s -o /etc/init.d/solr $initshurl

	# Change file to be executable
	chmod +x /etc/init.d/solr

	# Change references from Jetty configuration to Solr
	perl -pi -e 's/\/default\/jetty/\/sysconfig\/solr/g' /etc/init.d/solr

	# Enable the Solr service
	chkconfig solr on

	restart=1
fi

if [[ ! -z "$restart" ]];then
	service solr restart
fi





