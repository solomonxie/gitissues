FROM python:3-alpine

MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git

# Setup for ssh onto github
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

COPY . /Gitissues
RUN python3 -m pip install --no-cache-dir -r /Gitissues/requirements.txt

# CMD "python3 /Gitissues/all_in_one.py 2>&1"
CMD "/bin/sh"
