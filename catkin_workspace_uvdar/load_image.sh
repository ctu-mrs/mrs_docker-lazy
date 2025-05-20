#!/bin/bash

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed."

    # Ask for user confirmation
    read -p "Do you want to install Ansible? (y/n): " choice
    case "$choice" in 
      y|Y ) 
        echo "Installing Ansible..."
        sudo apt update -y && sudo apt install -y ansible
        echo "Ansible has been installed."
        ;;
      n|N ) 
        echo "Installation canceled."
        exit 1
        ;;
      * ) 
        echo "Invalid input. Please enter y or n."
        exit 1
        ;;
    esac
else
    echo "OK. Ansible is already installed."
fi
ansible-playbook -i inventory.ini load_docker_image.yaml --ask-become-pass
