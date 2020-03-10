#!/bin/sh

# start cron
/usr/sbin/crond -f -l 8

# SSH
chmod 700 /root/.ssh/id_rsa
