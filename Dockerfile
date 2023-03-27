# Utilisez une image Python pour exécuter l'application
#FROM python:3.9
FROM python:3.6-alpine

# Copier les fichiers de l'application vers l'image
#WORKDIR /app
#COPY . /app

WORKDIR /opt
#COPY . /opt

RUN apk update
RUN apk add git
RUN git clone https://github.com/sadofrazer/ic-webapp.git /opt/ 

RUN pip install flask==1.1.2

#RUN apt-get update -y && apt-get install python-dev python3-dev libsasl2-dev python-dev libldap2-dev libssl-dev -y

# Installez les dépendances de l'application
#RUN pip install --no-cache-dir -r requirements.txt


#RUN pip install flask==2.1.0 flask_httpauth==4.1.0 flask_simpleldap python-dotenv==0.14.0

# Définir les variables d'environnement pour les URL Odoo et pgAdmin
ENV ODOO_URL=http://www.odoo.com
ENV PGADMIN_URL=http://www.pgadmin.org

# Exposez le port 8000 pour accéder à l'application
EXPOSE 5000

# Démarrez l'application web vitrine
#CMD ["python", "app.py"]
ENTRYPOINT ["python", "app.py"]
