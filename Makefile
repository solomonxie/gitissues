build:
	docker build -t solomonxie/gitissues-docker:latest .
	# docker-compose build .

run:
	docker rm -f gitissues |true
	docker run -it --name gitissues --restart always \
		-v ~/.ssh:/root/.ssh -e TOKEN=${TOKEN} \
		solomonxie/gitissues-docker:latest /bin/sh
