# 🐢 mrs_docker_lazy

**mrs_docker_lazy** offers a smooth and efficient workflow for Docker users especially when managing multiple remote machines.

---

## ✨ Features

- 🚀 Simplified workflow
- 🌐 Scalable across multiple remote machines
- 🚫 Never SSH: you can work always on your local machine
- 📡 No Internet needed.
 
## 🐳 Requirements

Ensure the following are installed on your **local** machine:

- [Docker](https://www.docker.com/)
- [LazyDocker](https://github.com/jesseduffield/lazydocker)
- [Ansible](https://www.ansible.com/)
- [Tmuxinator](https://github.com/tmuxinator/tmuxinator)


- Copy both the private and public SSH keys from `./ssh` to your SSH configuration folder (usually `~/.ssh`).



## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone git@github.com:manuelboldrer/mrs_docker_lazy.git ~/git/mrs_docker_lazy
```

### 2. Prepare the Remote Machine(s)

- Install **Docker**.
- Ensure the **public SSH key** is added to `~/.ssh/authorized_keys`.  
  You can use:

```bash
ssh-copy-id -i ~/.ssh/ansible remote_user@192.168.69.1xx
```

- Enable remote access to Docker:

```bash
sudo systemctl edit docker.service
```

Add:

```ini
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd=/run/containerd/containerd.sock
```

Then:

```bash
sudo systemctl restart docker.service
```

Verify the service is active.

---

## 🚀 Usage

### 1. Create and Load Docker Images to Remote Machines

If you're not using DockerHub or a local registry:

- Edit `inventory.ini` to include remote IPs and usernames.
- Add your image folder to `load_custom_config/shared_data/`.
- Run:

```bash
./run_all.sh
```

> ⚙️ In `build_image.sh`, `export_image.sh`, and `image_loader/load_docker_image.yml`, be sure to set the correct **image name**.

### 2. Compile Workspace (arm64/amd64), Create and Load Docker Images to Remote Machines

Place your workspace inside:

```
catkin_workspace_uvdar/src
```

change `inventory.ini` and `common_vars.sh` properly and run `./run_all.sh` 

### 3. Start TMUX Session

- Configure `tmux_session/session.yml`.
- Run:

```bash
cd tmux_session
./start.sh
```

### 4. Run in Synchronous Mode

```bash
./up.sh && lazydocker
```

> 🐞 **Note:** Lazydocker can be buggy in "stack" mode (if you run it in the same directory as the Docker Compose file). Change directory if it misbehaves.  
> ⚙️ You can run custom commands within Lazydocker (check the config in the `lazydocker/` folder). For more check [LazyDocker Docs](https://github.com/jesseduffield/lazydocker)

