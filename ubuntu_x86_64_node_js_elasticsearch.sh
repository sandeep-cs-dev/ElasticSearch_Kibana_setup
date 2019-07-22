#!/usr/bin/env bash

# update apt
sudo apt-get update
# node js installation 
sudo apt-get install -y build-essential
sudo apt-get install curl python-software-properties
sudo apt-get install apt-transport-https
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo node -v 
sudo npm -v 
sudo apt-get install -y default-jdk
sudo wget -P /home/vagrant https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.0-amd64.deb
sudo dpkg -i /home/vagrant/elasticsearch-7.0.0-amd64.deb

# allow host OS to access through port forwarding
sudo echo "
network.bind_host: 0
network.host: 0.0.0.0
discovery.type: single-node" >> /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml

# restart elasticsearch to apply the above configuration
 sudo service elasticsearch restart
# start elastic search when system boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service

# kibana installation

echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install -y kibana

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service

sudo systemctl start kibana.service

# configure to expose kibana to host machine 
# kibana config file /etc/kibana/kibana.yml
echo "server.host: 0.0.0.0" | sudo tee -a /etc/kibana/kibana.yml
