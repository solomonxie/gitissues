#!/bin/sh
chmod 700 /root/.ssh/id_rsa

# start cron
/usr/sbin/crond -fd 0 2>&1 > /tmp/cron.log &
# /usr/sbin/crond -f -l 8
