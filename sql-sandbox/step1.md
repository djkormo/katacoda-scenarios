
Install postgresql on Ubuntu 16.04

`cat /sudo apt-get update`{{execute}}


`sudo apt-get update`{{execute}}


`sudo apt-get install postgresql postgresql-contrib`{{execute}}


`sudo -u postgres psql`{{execute}}


`ALTER USER postgres WITH ENCRYPTED PASSWORD 'Pa$$wrd';`{{execute}}

`\q`{{execute}}

`sudo service postgresql restart`{{execute}}

`systemctl status postgresql`{{execute}}




