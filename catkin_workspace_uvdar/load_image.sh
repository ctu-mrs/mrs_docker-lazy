#!/bin/bash

ansible-playbook -i inventory.ini load_docker_image.yaml --ask-become-pass
