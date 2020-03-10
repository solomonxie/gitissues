#!/bin/sh

# start cron
/usr/bin/crontab /crontab.txt
# /usr/sbin/crond -f -l 8
# /usr/sbin/crond -fd 0

# SSH
chmod 700 /root/.ssh/id_rsa
