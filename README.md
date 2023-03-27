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
---
# Utilisez une image Python pour exécuter l'application
FROM python:3.6-alpine

# Copier les fichiers de l'application vers l'image

WORKDIR /opt

RUN apk update
RUN apk add git
RUN git clone https://github.com/sadofrazer/ic-webapp.git /opt/ 

RUN pip install flask==1.1.2

# Définir les variables d'environnement pour les URL Odoo et pgAdmin
ENV ODOO_URL=http://www.odoo.com
ENV PGADMIN_URL=http://www.pgadmin.org

EXPOSE 8080

# Démarrez l'application web vitrine]
ENTRYPOINT ["python", "app.py"]
---