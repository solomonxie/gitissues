FROM python:3-alpine

MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git openssh-client

# Install requirements
COPY . /Gitissues
RUN python3 -m pip install --no-cache-dir -r /Gitissues/requirements.txt

# Setup for ssh onto github
RUN mkdir -p /root/.ssh
# RUN echo "${ID_RSA}" > /root/.ssh/id_rsa \
# RUN echo "${ID_RSA_PUB}" > /root/.ssh/id_rsa.pub
# RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add github key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Add cronjob
ADD crontab.txt /crontab.txt
RUN /usr/bin/crontab /crontab.txt

# Add entry
COPY entry.sh /entry.sh
RUN chmod 755 /entry.sh

CMD ["/entry.sh"]
