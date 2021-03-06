#!/bin/bash

# build a Docker image from the Dockerfile
docker build -t staticsite:1.0 .

# run the image in a Docker container
docker run -itd --name my-web-container --publish 8080:80 staticsite:1.0
