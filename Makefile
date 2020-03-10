build:
	docker build --build-arg \
		ID_RSA="$(cat ~/.ssh/id_rsa)" ID_RSA_PUB="$(cat ~/.ssh/id_rsa.pub)" \
		ACCESS_KEY="$(cat ~/.ssh/github_token.txt)"
		-t solomonxie/gitissues-docker:latest .

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
	python3 all_in_one.py 2>&1 >> /info.log
