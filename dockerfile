# Use the official Ubuntu image as the base image
FROM ubuntu

# Update the package lists and install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx index.html file
RUN rm /var/www/html/index.nginx-debian.html

# Copy the custom index.html file into the Nginx default HTML director
COPY index.html /var/www/html 

# Copy the custom Nginx configuration file
#COPY default /usr/share/nginx/html/sites-available/default

# Start Nginx in the foreground
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
