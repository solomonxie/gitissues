build:
	docker build -t solomonxie/gitissues-docker:latest .
	# docker-compose build .

run:
	docker rm -f gitissues |true
	docker run -dt --name gitissues --restart always \
		-v ~/.ssh:/root/.ssh -e TOKEN=${TOKEN} \
		solomonxie/gitissues-docker:latest

dryrun:
	docker run -it --rm --name gitissues \
		-v ~/.ssh:/root/.ssh -e TOKEN=${TOKEN} \
		solomonxie/gitissues-docker:latest /bin/sh

into:
	docker exec -it gitissues /bin/sh
