#!/bin/bash
docker run -d -p 5000:5000 --name registry registry:2
docker tag alpine localhost:5000/alpine
docker buildx imagetools create --tag localhost:5000/alpine \
  docker.io/alpine:latest

# docker tag elmanuel92/rbl_robofly:1.0.2 localhost:5000/rbl_robofly
# docker buildx imagetools create --tag localhost:5000/rbl_robofly \
#   docker.io/elmanuel92/rbl_robofly:1.0.2
