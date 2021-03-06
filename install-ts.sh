#!/bin/bash
apt update
apt upgrade
apt-get -y install build-essential libpcre3 libpcre3-dev libssl-dev php7.2 php7.2-fpm php7.2-mysql
service php7.2-fpm start
tar -xvf nginx-server.tar.gz
cd nginx-1.15.0
./configure --add-module=../nginx-ts-module
make
make install
cd ../
mkdir /usr/local/nginx/scripts
mkdir /usr/local/nginx/js
mv data/nginx.conf /usr/local/nginx/conf/
mv data/index.html /usr/local/nginx/html/
mv data/upload.php /usr/local/nginx/scripts/
mv data/player.js /usr/local/nginx/js/
rm -rf data/
cd /usr/local/nginx/js/
curl https://raw.githubusercontent.com/google/shaka-player/master/build/install-linux-prereqs.sh | bash
git clone https://github.com/google/shaka-player.git
cd shaka-player
python build/all.py

