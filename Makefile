build:
	docker build . -t solomonxie/gitissues-docker:latest \
		--build-arg ID_RSA="`cat ~/.ssh/id_rsa`" \
		--build-arg ID_RSA_PUB="`cat ~/.ssh/id_rsa.pub`" \
		--build-arg GITHUB_TOKEN="`cat ~/.ssh/github_token.txt`"

up:
	docker rm -f gitissues |true
	docker run -dt --name gitissues --restart always \
		-v ~/.ssh/id_rsa:/root/.ssh/id_rsa -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest

dryrun:
	docker rm -f gitissues |true
	docker run -it --rm --name gitissues \
		-v ~/.ssh:/root/.ssh -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest /bin/sh

into:
	docker exec -it gitissues /bin/sh


run:
	TOKEN="$(cat /github_token.txt)" python3 /Gitissues/all_in_one.py 2>&1 >> /info.log

haha:
	@echo `cat ~/.ssh/github_token.txt`

