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
