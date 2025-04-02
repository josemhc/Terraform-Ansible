FROM httpd:latest

# Copia el archivo de configuración de Apache
COPY ./my-httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

# Copia la página al directorio correcto
COPY ./index.html /usr/local/apache2/htdocs/index.html

# Expone el puerto 80
EXPOSE 80

# Usa el CMD predeterminado de httpd

