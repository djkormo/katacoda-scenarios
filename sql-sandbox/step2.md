Install mysql on Ubuntu 16.04

`apt-get update`{{execute}}

`docker pull mysql/mysql-server:5.7`{{execute}}

`docker run --name=mysqlCon -p 3306:3306 -d mysql/mysql-server:5.7`{{execute}}

`sudo docker logs mysqlCon`{{execute}}

`sudo docker exec -it mysqlCon mysql -uroot -p`{{execute}}

`ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewPassword';`{{execute}}

`GRANT ALL PRIVILEGES ON *.* to root@'%' IDENTIFIED BY 'root';`{{execute}}


`docker run -it --rm -p 8080:8080 -p 25482:25482 taivokasper/omnidb`{{execute}}