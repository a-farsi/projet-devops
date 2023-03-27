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

The **--name test-ic-webapp** allows to rename the generated container
the **-d **option to launch is in detached mode
**--rm** to delete it when it's stoped
**-p 8080:8080** to expose the container's port to be reached by external requests

