# docker-centos7-nfs-client-autofs
This Centos7 client runs systemd and installs NFS utils and autofs for NFS client functionality.

I created a new Centos7 NFS client that leverages images that run systemd to allow us to do the following:

Connect to NFSv3 and NFSv4.1 shares
Use autofs to leverage automounter
The client requires a script to run after the image is started.

The Dockerfile configures autofs with a mount. That part of the file would need to be customized.

Steps to run this image:

1) Create folder on Docker host 2) Copy script and dbus.service files to the folder. 3) Copy Dockerfile contents to new Dockerfile instance and modify the necessary attributes. 4) Build the Docker image:

docker build -t name/centos7-nfs-client-autofs .

5) Run the Docker image to start systemd with the following syntax:

docker run –privileged -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro parisi/nfs-client sh -c “/usr/lib/systemd/systemd”

6) Get the Docker image ID. Access the client with the docker exec command:

docker images docker exec -t -i [docker image ID] /bin/bash

Full results posted in this blog post:
