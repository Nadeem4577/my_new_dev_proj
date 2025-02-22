# Use the lightweight Nginx image
FROM nginx:alpine
# Copy your HTML file to the Nginx server
COPY index.html /usr/share/nginx/html