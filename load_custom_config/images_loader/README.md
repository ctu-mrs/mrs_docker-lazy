# Installation
Copy both the private and public SSH keys from `./ssh` to your SSH configuration folder (typically `~/.ssh`).
Be sure that the public key is added to the remote machines (check `~/.ssh/authrized_keys`). If it is not, you can add it using `ssh-copy-id -i ~/.ssh/ansible uav@192.168.69.1xx`.
The `load_image.sh` script will install Ansible using pip if it is not already installed.

# Usage
In `load_docker_image.yml` set the path and the name of the image you want to load.
In `inventory.ini` set the remote machines where you want to load the image, then `./load_image.sh`.


