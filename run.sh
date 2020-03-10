#!/bin/sh

date >> /cc.sh
TOKEN="$(cat /github_token.txt)" python3 /Gitissues/all_in_one.py > info.log 2>&1 &
