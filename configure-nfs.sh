#!/bin/sh

# Start services
service rpcidmapd start
service rpcbind start
service autofs start

# Kill autofs pid and restart, because Linux
ps -ef | grep '/usr/sbin/automount' | awk '{print $2}' | xargs kill -9
service autofs start
