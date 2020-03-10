build:
	docker build . -t solomonxie/gitissues-docker:latest \
		--build-arg ID_RSA="`cat ~/.ssh/id_rsa`" \
		--build-arg ID_RSA_PUB="`cat ~/.ssh/id_rsa.pub`" \
		--build-arg GITHUB_TOKEN="`cat ~/.ssh/github_token.txt`"

up:
	docker rm -f gitissues |true
	docker run -dt --name gitissues --restart always \
		-v .:/Gitissues -e TOKEN="${TOKEN}" solomonxie/gitissues-docker:latest

dryrun:
	docker rm -f gitissues |true
	docker run -it --rm --name gitissues \
		-v ~/.ssh:/root/.ssh -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest /bin/sh

into:
	docker exec -it gitissues /bin/sh


run:
	cat run.sh > sh

haha:
	@echo `cat ~/.ssh/github_token.txt`

