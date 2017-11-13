#!/bin/bash

git clone https://github.com/lord/slate.git
cp ./docker-compose.yml ./slate
cp ./Dockerfile ./slate
cd ./slate

# After the files have been created, you can run Slate with 
docker-compose up

# To build a local static copy of your API documentation into the build directory, run
# docker run --rm -v $PWD:/usr/src/app/source -w /usr/src/app/source dockerapi_api bundle exec middleman build --clean
