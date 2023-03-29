# projet-devops
Please find the project statement by clicking on this link : ![https://github.com/sadofrazer/ic-webapp](https://github.com/sadofrazer/ic-webapp)

# 2.a) Containerizing of the web application. 
Our web application is developped in Python and use the Flask module to be executed. Here are the steps to follow in order to containerize the web application: 

1. Use the base image **python:3.6-alpine** for building the new image
2. Set the **/opt** directory inside the container to be the working directory
3. Install  the **version 1.1.2** of the Flask* module using **pip install flask==1.1.2**
4. Expose the port number **8080** which is the default port used by the application
5. Create environment variables **ODOO_URL** and **PGADMIN_URL** to define the URLs of odoo and pgadmin, respectively.
6. Launch the **app.py** application in **ENTRYPOINT** using the command **python**.

The propose Dockerfile will be as follows : 
```
# Use this base image to execute the application
FROM python:3.6-alpine

# Specify the working directory
WORKDIR /opt

# Update and install Git to get the application's source code from github 
RUN apk update
RUN apk add git
RUN git clone https://github.com/sadofrazer/ic-webapp.git /opt/ 

# Install the Flask module 
RUN pip install flask==1.1.2

# Define the environment variables to set urls of Odoo and pgAdmin applications
ENV ODOO_URL=http://www.odoo.com
ENV PGADMIN_URL=http://www.pgadmin.org

# Expose the default port
EXPOSE 8080

# Launch the application
ENTRYPOINT ["python", "app.py"]
```
From this Dockerfile we can generate the image **ic-webapp** with a tag **1.0** by executong the following vommand : 

```
 docker build -t ic-webapp:1.0 .
```
Then we can launch our container by executing the previous generated image using this command :

```
 docker run --name test-ic-webapp -d --rm -p 8080:8080 ic-webapp:1.0
```
Here are explanations of the specified options : 

- The **--name test-ic-webapp** allows to rename the generated container.
- The **-d** option to launch is in detached mode.
- The option **--rm** to delete it when it's stoped.
- The option **-p 8080:8080** to expose the container's port to be reached by external requests.

Let's ignore the **-d** option to get more details about the container. The figure bellow illutrate the output of the command line:   

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228029592-8d3330da-c61e-4386-8f95-07dde5c28b68.png">
</p>

We can see that's the container is launched on the url : http://172.17.0.2:8080. In fact, this ip address corresponds to the address assigned to the Docker container, and in practice, it should never be used to reach the container from outside. The practical alternative is to use the host ip address with the mapped port.

To get the docker host ip address we execute the commande:

```
ip a
```
We get our ip adress (the one in the red box)


<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228523668-bb6077c8-f495-4750-8d3f-2fc15486dd20.png">
</p>



We launch an internet navigator and type the url (composed of the docker host ip address and the docker host port) to get the application displayed as shown in the following figure :

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228526110-b4740ffe-7ca2-4d85-9283-2a1369a34394.png">
</p>

We delete our container either : 
- Automaticaly by using the option **--rm**, when it's stopped.
- Or by executing the following command : 

```
 docker docker rm <DOCKER_NAME>
```
In our case <DOCKER_NAME> should be replace by **test-ic-webapp**


To push our image on the Docker Hub, we first follow the following steps : 

We login on our docker-hub account by typing the following command : 

```
 docker login
```
This figure shows that we connected to our docker-hub account successfylly. 
<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228038534-6ed7d02c-fc83-4b33-9880-f3a4589162a8.png">
</p>

Then, we tag our image as follows : 

```
 docker tag ic-webapp:1:0 afarsi/ic-webapp:1:0
```

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228038662-d813cb6d-647b-4e79-97d1-93ec953b131a.png">
</p>

To display all docker images and check that our taged image has already been created, we execute the command : 

```
 docker images
```
And this figure shows that the **afarsi/ic-webapp:1:0** image with other existing ones 

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228039608-84ee9c3f-d143-4410-bea6-2ae9510eee4a.png">
</p>

After that, we push our  taged image to the docker-hub account. To do that we type the command : 

```
 docker push afarsi/ic-webapp:1:0
```
Here is the result of pushing our images on docker-hub :
<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228039477-722045e5-7ca8-430d-a211-a4d174784463.png">
</p>

We connect through an internet navigator to our Docker hub account in order to check that our images is present as shown by this figgure: 

Image sur Docker Hub :
<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228039095-2c4efb88-7a82-42fd-a0ba-083f62c887c7.png">
</p>

# 2.b) Containerizing of web application, oodo and pgAdmin. 

In this section we will containerize the three application : ic-webapp, oodo and pgAdmin.
We'll allow to a user to access to both oodo and pgAdmin from the fronted by clicking on their images.

We should modify the environment variables to point to the service instead of the publlic url as shown in the Dockerfile bellow :

```
# Utilisez une image Python pour exécuter l'application
FROM python:3.6-alpine

# Copier les fichiers de l'application vers l'image

WORKDIR /opt

RUN apk update
RUN apk add git
RUN git clone https://github.com/sadofrazer/ic-webapp.git /opt/ 

RUN pip install flask==1.1.2

# Définir les variables d'environnement pour les URL Odoo et pgAdmi
ENV ODOO_URL=odoo:8069
ENV PGADMIN_URL=pgadmin:5050

EXPOSE 8080

# Démarrez l'application web vitrine]
ENTRYPOINT ["python", "app.py"]

```

Here is the docker-compose file : 

```
version: "3.9"

services:
  ic-webapp:
    build: .
    ports:
      - "8080:8080"
    networks:
      - webapp_network

  odoo13:
    container_name: odoo13
    image: odoo:13
    networks:
      - webapp_network
    tty: true
    command: -- --dev=reload
    volumes:
      - ./addons:/mnt/extra-addons
      - ./etc:/etc/odoo
    restart: always

  pgadmin:
    container_name: pgadmin_container
    image: dpage/pgadmin4
    environment:
      - PGADMIN_DEFAULT_EMAIL=pgadmin4@pgadmin.org
      - PGADMIN_DEFAULT_PASSWORD=admin
    networks:
      - webapp_network
    restart: always
    
networks:
  webapp_network:
    driver: bridge


```
We launch the docker compose by typing the following command : 

```
docker compose up -d
```
We will get the same render as in the figure above. But when we click on the oddo icon, we are directed to the oddo service this times  

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228629323-e927b6a0-d2bc-4aa4-839c-e1dfc698bf1a.png">
</p>

The same thing for the pgAdmin service 


<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228629496-843485ae-f2b5-4a10-83ec-7d0b3cf77156.png">
</p>

We see this time that url contains the service name instead of the public url.


