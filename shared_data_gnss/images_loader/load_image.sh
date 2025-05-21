#!/bin/bash

ansible-playbook -i ../../inventory.ini load_docker_image.yml --ask-become-pass
# ansible-playbook -i inventory.ini load_docker_image.yml --become --ask-become-pass
