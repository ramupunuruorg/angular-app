# Stage 1 Alpine based image with nodejs
FROM node:14-alpine AS builder
# Set the working directory to /app in the container
WORKDIR /app
# Copy the package.json and package-lock.json files to the container
COPY package*.json ./
# Install Angular CLI globally
RUN npm install -g @angular/cli@13.3.5
# Install project dependencies
RUN npm install --force
# Copy the entire Angular project to the container
COPY . .
# Build the Angular application for production
RUN ng build
# Use an official Nginx image as the base image for serving the Angular app
FROM nginx:alpine
# remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
# Copy the built Angular app from the build container to the Nginx web root directory
COPY --from=builder /app/dist/my-project /usr/share/nginx/html
# change the ownership
RUN chown -R nginx:nginx /usr/share/nginx/html
# change the permissions
RUN chown -R 755 /usr/share/nginx/html
# Create user idp with uid and add it to the root group
RUN adduser -D -u 1000 idp && addgroup idp root
# Change the ownership of /var/cache/nginx
RUN chown -R idp:idp /var/cache/nginx
# Change the ownership of /var/run and change permissions to 755
RUN chown -R idp:idp /var/run/ && chmod -R 755 /var/run/
# Change the ownership of /var/run and change permissions to 755
# RUN chown -R idp:idp /var/run/nginx.pid && chmod -R 755 /var/run/nginx.pid
# Comment out the user directive in /etc/nginx/conf.d/default.conf
RUN sed -i 's/^user/#user/' /etc/nginx/nginx.conf
# Replace port 80 with 8080 in /etc/nginx/conf.d/default.conf
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf
# Fix Nginx SPA redirect
RUN sed -i '/index  index.html index.htm;/a \\ttry_files $uri $uri/ /index.html =404;' /etc/nginx/conf.d/default.conf
# Expose port 8080 for the Nginx server
EXPOSE 8080
# Switch to user idp
USER 1000
# Start Nginx when the Docker container runs
CMD ["nginx", "-g", "daemon off;"]
