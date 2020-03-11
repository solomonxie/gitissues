FROM python:3-alpine
MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git openssh-client

# Install requirements
COPY requirements.txt entry.sh /
RUN python3 -m pip install --no-cache-dir -r /requirements.txt

COPY /tmp/id_rsa rtmp/id_rsa.pub /root/.ssh/

CMD ["/bin/sh", "/entry.sh"]
