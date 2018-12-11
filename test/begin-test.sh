#!/bin/bash

name="debian_test"
dirname="bootstrap"
os="centos:latest"

docker run -t -d -v $(pwd)/../src:/$dirname --name $name $os \
	&& docker exec -it $name bash -c "cd /$dirname && ./begin.sh" \
	&& docker stop $name && docker rm $name;