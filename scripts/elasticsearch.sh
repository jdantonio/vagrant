#!/usr/bin/env bash

#set -e

echo 'Running Ubuntu elastic search script...'

# http://raphaelhertzog.com/2010/09/21/debian-conffile-configuration-file-managed-by-dpkg/
es_data_path="/usr/share/elasticsearch/data"
es_deb="elasticsearch-1.4.0.deb"
es_deb_url="https://download.elasticsearch.org/elasticsearch/elasticsearch/$es_deb"
apt-get remove -y elasticsearch
curl -ksSLO $es_deb_url
dpkg -i --force-confold $es_deb
rm $es_deb

service elasticsearch stop

mkdir -p  $es_data_path
chmod 777 $es_data_path

echo "manual" > /etc/init/elasticsearch.override
echo 'export PATH=$PATH:/usr/share/elasticsearch/bin' > /etc/profile.d/elasticsearchpath.sh

cp -f /vagrant/templates/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# install ElasticHQ as a plugin
# http://localhost:9200/_plugin/HQ
if [ ! -d /usr/share/elasticsearch/plugins/HQ ]; then
  cd /usr/share/elasticsearch
  bin/plugin -install royrusso/elasticsearch-HQ
fi
