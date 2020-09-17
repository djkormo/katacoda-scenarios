https://medium.com/@migueldoctor/run-mysql-phpmyadmin-locally-in-3-steps-using-docker-74eb735fa1fc


`docker pull mysql:8.0.1`{{execute}}

The previous command will download the version 8.0.1 of mysql within an image available in the Docker store, so now you can run it into your local machine:

`docker run --name my-own-mysql -e MYSQL_ROOT_PASSWORD=mypass123 -d mysql:8.0.1`{{execute}}

Let's explain the options for the command docker run.

    The option --name allows us to assign a specific name for our running container.
    The option -e is used to pass a value for the container environment variable MYSQL_ROOT_PASSWORD. This variable is requested by the image to run properly and it will be assigned to the root password of MySQL. More information about this image can be found in docker hub (here).
    The option -d means that docker will run the container in the background in “detached” mode. If -d is not used the container run in the default foreground mode.
    Finally, we need to indicate docker to use the image mysql:8.0.1 just downloaded, to run the container.

If everything went well you could see the running container by typing the following command:

`docker ps -a`{{execute}}

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
d47128c8198c        mysql:8.0.1        "docker-entrypoint.s…"   33 seconds ago      Up 32 seconds       3306/tcp, 33060/tcp   my-own-mysql

Step 2: Obtaining and running phpMyAdmin docker container

Once the container running MySql server is working, the next step is configuring another container with phpMyAdmin. A quick search in docker hub by phpMyAdmin will show us a list of phpMyAdmin related images. In our case, we select the following one (https://hub.docker.com/r/phpmyadmin/phpmyadmin) which includes, not only an instance of phpMyAdmin, but also all components required by the app like a Nginx web server with PHP.

To download the latest stable version of the image, open a terminal and type the following:

`docker pull phpmyadmin/phpmyadmin:latest`{{execute}}

After downloading the image, we need to run the container making sure that the container connects with the other container running mysql. In order to do so we type the following command:

`docker run --name my-own-phpmyadmin -d --link my-own-mysql:db -p 8081:80 phpmyadmin/phpmyadmin`{{execute}}


`docker ps -a`{{execute}}