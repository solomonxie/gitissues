build:
	docker build -t solomonxie/gitissues-docker:latest .

run:
	docker run -dt --name gitissues --restart always solomonxie/gitissues-docker:latest
