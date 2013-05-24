#!/bin/sh
echo "<VirtualHost *:80>
  ServerAdmin 1@royaldt.dev
	ServerName $1
	DocumentRoot /srv/www/htdocs/$1
	ErrorLog  /srv/www/htdocs/$1/error_log
        CustomLog  /srv/www/htdocs/$1/access_log combined    
        <Directory /srv/www/htdocs/$1/>
    	    Options None
            AllowOverride All
            Order deny,allow
            Allow from all
	</Directory>
</VirtualHost>" > /etc/apache2/vhosts.d/$1.conf

echo "Created $1.conf in /etc/apache2/vhosts.d/"

echo 127.0.0.1	$1 >> /etc/hosts

echo "Added Alias 127.0.0.1 $1 into /etc/hosts"

mkdir /srv/www/htdocs/$1

echo "Created directory /srv/www/htdocs/$1"

chmod 777 /srv/www/htdocs/$1

echo "Warning! Chmod 777! For site dir."

echo "<h1>$1</h1>" > /srv/www/htdocs/$1/index.html

echo "Created default html file"

#my access for mysql root:root
/usr/bin/mysql -uroot -proot mysql -e "CREATE DATABASE IF NOT EXISTS $1;"

echo "Created database $1"

/etc/init.d/apache2 reload

echo "Your site has ready http://$1/"
