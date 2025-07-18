# 🐢 mrs_docker-lazy

**mrs_docker-lazy** offers a smooth and efficient workflow for Docker users especially when managing multiple remote machines.

---

## ✨ Features

- 🚀 Simplified workflow
- 🌐 Scalable across multiple remote machines
- 🚫 Never SSH: you can work always on your local machine
- 📡 No Internet needed.
 
## 🐳 Requirements

Ensure the following are installed on your **local** machine:

- [Docker](https://docs.docker.com/engine/install/)
- [LazyDocker](https://github.com/jesseduffield/lazydocker)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) 
- [Tmuxinator](https://github.com/tmuxinator/tmuxinator)


- Copy both the private and public SSH keys from `./ssh` to your SSH configuration folder (usually `~/.ssh`).



## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone git@github.com:manuelboldrer/mrs_docker-lazy.git ~/git/mrs_docker-lazy
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

If do not want to DockerHub or a local registry, a nice alternative is to use Ansible:

- Edit `inventory.ini` to include remote IPs and usernames.
- Add your image folder to `load_custom_config/shared_data/`.
- Run:

```bash
./run_all.sh
```

> ⚙️ In `build_image.sh`, `export_image.sh`, and `image_loader/load_docker_image.yml`, be sure to set the correct **image name**. (it should be fixed)

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

> 📡 To not rely on internet you can pull the images from a local registry. For example, run registry.sh, it will create your registry with the alpine image. Then for instance in your shared_data_gnss specify in the Dockerfile: FROM localhost:5000/alpine. 

> 👜 To save rosbags, first use the custom command added in the lazydocker config.yml (this allow to properly stop the rosbag container, avoiding the .active. If you want to keep the rosbags change the script down.sh in such a way it does not delete volumes. 

### 5. Example of Workflow with two roboflies
[![Watch on YouTube](https://youtu.be/Z_iTzb2265M)](https://youtu.be/Z_iTzb2265M)

