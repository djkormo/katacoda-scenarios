
Install postgresql on Ubuntu 16.04

`cat /etc/os-release`{{execute}}


`sudo apt-get update`{{execute}}


`sudo apt-get install postgresql postgresql-contrib  phppgadmin -y `{{execute}}


`sudo -u postgres psql`{{execute}}


`ALTER USER postgres WITH ENCRYPTED PASSWORD 'Pa$$wrd';`{{execute}}

`\q`{{execute}}

`sudo service postgresql restart`{{execute}}


`systemctl status postgresql`{{execute}}

`systemctl status apache2`{{execute}}


cd /etc/apache2/conf-available/
nano phppgadmin.conf


`cat /etc/apache2/conf-available/phppgadmin.conf |grep "Require local"`{{execute}}

Comment out the line #Require local by adding a # in front of the line and add below the line allow from all so that you can access from your browser.

`sed -i  s/'#Require local'/'##Require local'/g   /etc/apache2/conf-available/phppgadmin.conf`{{execute}}


`cat /etc/apache2/conf-available/phppgadmin.conf |grep "Require local"`{{execute}}

Edit the file /etc/phppgadmin/config.inc.php by typing :

cd /etc/phppgadmin/
nano config.inc.php

`cat /etc/phppgadmin/config.inc.php |grep "conf\['extra_login_security'\]"`{{execute}}

`sed -i s/'conf['extra_login_security'] = true'/'conf['extra_login_security'] = false'/g /etc/phppgadmin/config.inc.php`{execute}

`cat /etc/phppgadmin/config.inc.php |grep "conf\['extra_login_security'\]"`{{execute}}


Find the line $conf['extra_login_security'] = true; and change the value to false so you can login to phpPgAdmin with user postgres.


`systemctl restart postgresql`{{execute}}
`systemctl restart apache2`{{execute}}

