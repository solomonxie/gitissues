FROM python:3-alpine

MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git

# Setup for ssh onto github
# RUN mkdir -p /root/.ssh
# ARG ID_RSA
# ARG ID_RSA_PUB
# RUN echo "${ID_RSA}" > /root/.ssh/id_rsa \
# RUN echo "${ID_RSA_PUB}" > /root/.ssh/id_rsa.pub
# RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

COPY . /Gitissues
RUN python3 -m pip install --no-cache-dir -r /Gitissues/requirements.txt

# CMD "python3 /Gitissues/all_in_one.py 2>&1"
CMD "/bin/sh"
