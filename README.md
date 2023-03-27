# projet-devops
Please find the project statement by clicking on this link : ![https://github.com/sadofrazer/ic-webapp](https://github.com/sadofrazer/ic-webapp)

# 2) Containerizing of the web application. 
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

We can see that's the container is launched on the url : http://172.17.0.2:8080.

We launch an internet navigator and type this url to get the application displayed as shown in the following figure :

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228032519-f4620e02-fbbe-4746-817d-1ee6ccf59157.png">
</p>

We delete our container either : 
- Automaticaly by using the option **--rm** and weill be deleted when it's stopped.
- Or by executing the following command : 

```
 docker docker rm <DOCKER_NAME>
```
In our case <DOCKER_NAME> should be replace by **test-ic-webapp**


To push our image on the Docker Hub, we first need to tag it 

login 

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228038534-6ed7d02c-fc83-4b33-9880-f3a4589162a8.png">
</p>


tag : 

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228038662-d813cb6d-647b-4e79-97d1-93ec953b131a.png">
</p>


images : 

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228039608-84ee9c3f-d143-4410-bea6-2ae9510eee4a.png">
</p>



push : 

<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228039477-722045e5-7ca8-430d-a211-a4d174784463.png">
</p>


Image sur Docker Hub :
<p align="center">
<img src="https://user-images.githubusercontent.com/40942166/228039095-2c4efb88-7a82-42fd-a0ba-083f62c887c7.png">
</p>





