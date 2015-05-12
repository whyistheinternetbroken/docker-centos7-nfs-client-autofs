FROM centos:centos7
ENV container docker
MAINTAINER: Justin Parisi "whyistheinternetbroken@gmail.com"
RUN yum -y update; yum clean all
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y install nfs-utils; yum clean all
RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount
RUN systemctl mask display-manager.service systemd-logind.service
RUN systemctl disable graphical.target; systemctl enable multi-user.target

# Copy the dbus.service file from systemd to location with Dockerfile
COPY dbus.service /usr/lib/systemd/system/dbus.service

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD  ["/usr/lib/systemd/systemd"]

# Make mount point
RUN mkdir /docker-nfs

# Configure autofs
RUN yum install -y autofs
RUN echo "/docker-nfs /etc/auto.misc --timeout=50" >> /etc/auto.master

###### CONFIGURE THIS PORTION TO YOUR OWN SPECS ######
#RUN echo "docker -fstype=nfs4,minorversion=1,rw,nosuid,hard,tcp,timeo=60 10.228.225.142:/docker" >> /etc/auto.misc
######################################################


# Copy the shell script to finish setup
COPY configure-nfs.sh /configure-nfs.sh
RUN chmod 777 configure-nfs.sh
