build:
	docker build . -t solomonxie/gitissues-docker:latest

run:
	docker rm -f gitissues |true
	source envgen.sh && env |grep \
		-E "(^GH_USER=)|(^GH_EMAIL=)|(^GH_TOKEN)|(^ID_RSA)|(^ID_RSA_PUB)" > /tmp/env.txt
	docker run -dt --name gitissues --restart always \
		--env-file=/tmp/env.txt -v ${PWD}:/Gitissues \
		solomonxie/gitissues-docker:latest
	rm /tmp/env.txt

into:
	docker exec -it gitissues /bin/sh

haha:
	@echo `cat ~/.ssh/github_token.txt`

