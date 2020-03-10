FROM python:3-alpine
MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

ARG ID_RSA
ARG ID_RSA_PUB
ARG GITHUB_TOKEN

RUN apk add --no-cache git openssh-client

# Install requirements
COPY . /Gitissues
RUN python3 -m pip install --no-cache-dir -r /Gitissues/requirements.txt

# Copy ssh-keys from host
RUN mkdir -p /root/.ssh
RUN echo "${ID_RSA}" > /root/.ssh/id_rsa && chmod 700 /root/.ssh/id_rsa
RUN echo "${ID_RSA_PUB}" > /root/.ssh/id_rsa.pub && chmod 700 /root/.ssh/id_rsa.pub
RUN echo "${GITHUB_TOKEN}" > /github_token.txt && chmod 700 /root/.ssh/github_token.txt

# Setup for ssh onto github
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Add cronjob
ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt

# Add entry
COPY entry.sh /entry.sh
RUN chmod 755 /entry.sh

CMD ["/entry.sh"]
