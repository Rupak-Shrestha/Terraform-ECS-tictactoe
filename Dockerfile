# Dockerfile for deploying a Tic Tac Toe web application using Nginx

# Use an official Nginx runtime as a parent image
FROM --platform=linux/amd64 nginx:latest

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Copy all the content of the Tic Tac Toe web application to the working directory
COPY tictactoe-app/* .

# Expose port 80 to allow external connections
EXPOSE 80

