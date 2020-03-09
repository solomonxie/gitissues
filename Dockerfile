FROM python:3-alpine

MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git openssh-client

# Setup for ssh onto github
COPY init.sh /init.sh
RUN chmod 777 /init.sh
RUN mkdir -p /root/.ssh
# RUN echo "${ID_RSA}" > /root/.ssh/id_rsa \
# RUN echo "${ID_RSA_PUB}" > /root/.ssh/id_rsa.pub
# RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add github key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

COPY . /Gitissues
RUN python3 -m pip install --no-cache-dir -r /Gitissues/requirements.txt

CMD "/run.sh"
