build:
	git config --global user.name "solomonxie"
	git config --global user.email "solomonxiewise@gmail.com"
	docker build . -t solomonxie/gitissues-docker:latest \
		--build-arg ID_RSA="`cat ~/.ssh/id_rsa`" \
		--build-arg ID_RSA_PUB="`cat ~/.ssh/id_rsa.pub`" \
		--build-arg GITHUB_TOKEN="`cat ~/.ssh/github_token.txt`" \
		--build-arg GITHUB_CFG="`cat ~/.gitconfig`"

up:
	docker rm -f gitissues |true
	docker run -dt --name gitissues --restart always \
		-v ~/Gitissues:/Gitissues -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest

dryrun:
	docker rm -f gitissues |true
	docker run -it --rm --name gitissues \
		-v ~/.ssh:/root/.ssh -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest /bin/sh

into:
	docker exec -it gitissues /bin/sh

haha:
	@echo `cat ~/.ssh/github_token.txt`

