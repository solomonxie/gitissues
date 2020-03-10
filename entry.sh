#!/bin/sh

# start cron
/usr/sbin/crond -fd 0 >> /tmp/cron.log 2>&1 &
# /usr/sbin/crond -f -l 8

# SSH
chmod 700 /root/.ssh/id_rsa
