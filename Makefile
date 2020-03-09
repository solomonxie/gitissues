build:
	docker build -t --squash solomonxie/gitissues-docker:latest .

run:
	docker run -dt --name gitissues --restart always \
		-e TOKEN=${TOKEN} \
		solomonxie/gitissues-docker:latest
