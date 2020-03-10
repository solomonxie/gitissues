#!/bin/sh

TOKEN="$(cat /github_token.txt)" python3 /Gitissues/all_in_one.py 2>&1 > info.log
