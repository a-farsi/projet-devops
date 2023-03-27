# projet-devops
Please find the project statement by clicking on this link : ![https://github.com/sadofrazer/ic-webapp](https://github.com/sadofrazer/ic-webapp)

# 2) Containerizing of the web application. 
Our web application is developped in Python and use the Flask module to be executed. Here are the steps that we follow in order to containerize the web application: 

1. Use the base image **python:3.6-alpine** for building the new image
2. Set the **/opt** directory inside the container to be the working directory
3. Install  the **version 1.1.2** of the Flask* module using **pip install flask==1.1.2**
4. Expose the port number **8080** which is the default port used by the application
5. Create environment variables **ODOO_URL** and **PGADMIN_URL** to define the URLs of odoo and pgadmin, respectively.
6. Launch the **app.py** application in **ENTRYPOINT** using the command **python**.


