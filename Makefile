.PHONY = clean publish
BASE_VERSION = $(shell git rev-list HEAD --count)-$(shell git branch --show-current)
GIT_STATUS = $(shell git status --porcelain)
VERSION = $(if $(GIT_STATUS),$(BASE_VERSION).dirty,$(BASE_VERSION))
IMAGE = docker.io/ahorgnies/pdf-to-png:$(VERSION)
IMAGE_STAMP = fita-dev-$(VERSION).stamp

$(IMAGE_STAMP): Dockerfile main.py
	docker build . -t $(IMAGE)
	@touch $(IMAGE_STAMP)

test-actual.png: file.pdf $(IMAGE_STAMP) test-expected.png
	docker run --rm -v .:/workdir $(IMAGE) file.pdf $@
	diff test-actual.png test-expected.png

publish: clean test-actual.png $(IMAGE_STAMP)
	docker push $(IMAGE)

clean:
	rm $(wildcard *.stamp) test-actual.png
