FROM python:3-alpine
MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git openssh-client

# Install requirements
COPY requirements.txt /requirements.txt
RUN python3 -m pip install --no-cache-dir -r /requirements.txt

ARG ID_RSA
ARG ID_RSA_PUB
# Copy ssh-keys from host
RUN mkdir -p /root/.ssh
RUN echo "${ID_RSA}" > /root/.ssh/id_rsa && chmod 700 /root/.ssh/id_rsa
RUN echo "${ID_RSA_PUB}" > /root/.ssh/id_rsa.pub && chmod 700 /root/.ssh/id_rsa.pub

# Setup for ssh onto github
ARG GITHUB_TOKEN
RUN echo "${GITHUB_TOKEN}" > /github_token.txt && chmod 700 /github_token.txt
ARG GITHUB_CFG
RUN echo "${GITHUB_CFG}" > /root/.gitconfig
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Add cronjob
ADD crontab.txt /crontab.txt
# RUN /usr/bin/crontab /crontab.txt
# RUN /usr/sbin/crond -fd 0 >> /tmp/cron.log 2>&1 &

# Add entry
COPY entry.sh /entry.sh
RUN chmod 755 /entry.sh
COPY run.sh /run.sh
RUN chmod 755 /run.sh

VOLUME /Gitissues
CMD ["/entry.sh"]
