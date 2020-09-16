Install mysql on Ubuntu 16.04

`apt-get update`{{execute}}

`docker network create -d bridge sql`{{execute}}

`docker pull mysql/mysql-server:5.7`{{execute}}

`docker run --network=host --name=mysqlCon -p 3306:3306 -d mysql/mysql-server:5.7`{{execute}}

`sudo docker logs mysqlCon`{{execute}}

`sudo docker exec -it mysqlCon mysql -uroot -p`{{execute}}

`ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewPassword';`{{execute}}

`GRANT ALL PRIVILEGES ON *.* to root@'%' IDENTIFIED BY 'root';`{{execute}}


`docker run  --network=sql -d  -p 8080:8080 -p 25482:25482 taivokasper/omnidb`{{execute}}

`docker run -d  --network=host -v config-omnidb:/etc/omnidb -p 8080:8080 -p 25482:25482 taivokasper/omnidb`


sudo docker exec -it mysqlCon cat /etc/mysql/mysql.conf.d/mysqld.cnf
