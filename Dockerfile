FROM python:3-alpine

MAINTAINER Solomon Xie <solomonxiewise@gmail.com>

RUN apk add --no-cache git

COPY ${HOME}/.ssh /root/.ssh

COPY . /Gitissues
RUN python3 -m pip install --no-cache-dir -r /Gitissues/requirements.txt

# CMD ["python3", "/Gitissues/all_in_one.py 2>&1"]
CMD "/bin/sh"
