build:
	# docker build -t --squash solomonxie/gitissues-docker:latest .
	docker-compose build .

run:
	docker run -dt --name gitissues --restart always \
		-e TOKEN=${TOKEN} \
		solomonxie/gitissues-docker:latest
