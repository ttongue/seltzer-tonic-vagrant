#!/usr/bin/bash

timedatectl set-timezone US/Eastern

# Start by updating all the packages and installing the rest of the LAMP stack
dnf update -y
dnf install -y mariadb-server mariadb-server httpd nodejs npm openssl vsftpd php php-mysql freetype libpng zlib-devel wget git python python-mysql postfix telnet
pip install braintree
pip install mailchimp

# Set up the MySQL / MariaDB database and install the current copy of the 
# system database for testing against live data.

systemctl enable mariadb.service 
systemctl start mariadb.service 
mysqladmin -u root password r3wtSQLpass
cd /vagrant/sql
mysql --password=r3wtSQLpass -u root < sample.sql 
echo "flush privileges;" | mysql --password=r3wtSQLpass -u root

# Make sure the www directory is pointing to the shared directory on /vagrant
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant/www /var/www
fi
if ! [ -L /var/wwws ]; then
  rm -rf /var/wwws
  ln -fs /vagrant/wwws /var/wwws
fi
cp /vagrant/configs/selinux-config /etc/selinux/config
cp /vagrant/configs/virtual_hosts.conf /etc/httpd/conf.d
cp /vagrant/configs/hosts /etc/hosts
cp /vagrant/configs/httpd.conf /etc/httpd/conf
setenforce 0
systemctl enable httpd
systemctl start httpd


cp /vagrant/configs/main.cf /etc/postfix
systemctl enable postfix
systemctl start postfix
