#!/bin/bash

CONTAINER_NAME='concealed_cader'

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
	docker rm -vf $CONTAINER_NAME
fi
