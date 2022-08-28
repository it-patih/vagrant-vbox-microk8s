#!/bin/bash

echo "###"
echo "### run-docker-containers.sh###"
echo "###"

echo "### Run goatandwolf:8.1.0"
mkdir -p /vagrant/.webgoat-8.1.0
chown vagrant:vagrant /vagrant/.webgoat-8.1.0
ln -sfn /vagrant/.webgoat-8.1.0 /home/vagrant/.webgoat-8.1.0
chown -h vagrant:vagrant /home/vagrant/.webgoat-8.1.0
docker run -d --rm -p 0.0.0.0:8080:8080 -p 0.0.0.0:9090:9090 -e TZ=Asia/Jakarta -v /home/vagrant/.webgoat-8.1.0:/home/webgoat/.webgoat-8.1.0 webgoat/goatandwolf:v8.1.0