build:
	docker build -t solomonxie/gitissues-docker:latest .
	# docker-compose build .

up:
	docker rm -f gitissues |true
	docker run -dt --name gitissues --restart always \
		-v ~/.ssh:/root/.ssh -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest

dryrun:
	docker rm -f gitissues |true
	docker run -it --rm --name gitissues \
		-v ~/.ssh:/root/.ssh -e TOKEN="${TOKEN}" \
		solomonxie/gitissues-docker:latest /bin/sh

into:
	docker exec -it gitissues /bin/sh


run:
	python3 /Gitissues/all_in_one.py 2>&1 >> /info.log
