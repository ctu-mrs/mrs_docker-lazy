#!/bin/bash
set -e

# Create the systemd override directory
sudo mkdir -p /etc/systemd/system/docker.service.d

# Create the override file
sudo tee /etc/systemd/system/docker.service.d/override.conf > /dev/null <<'EOF'
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd=/run/containerd/containerd.sock
EOF

# Reload systemd and restart Docker
sudo systemctl daemon-reexec
sudo systemctl restart docker

echo "Docker service override applied. Listening on Unix socket and TCP port 2375."
