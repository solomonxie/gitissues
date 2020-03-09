build:
	docker build --no-cache -t solomonxie/gitissues-docker:latest .

run:
	docker run -dt --restart always solomonxie/gitissues-docker:latest
