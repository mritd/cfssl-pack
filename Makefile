BUILD_VERSION   := $(shell cat version)

all: clean build

build:
	bash build.sh

release: all
	ghr -u mritd -t ${GITHUB_TOKEN} -replace -recreate --debug v${BUILD_VERSION} *.run 

pre-release: all
	ghr -u mritd -t ${GITHUB_TOKEN} -replace -recreate -prerelease --debug v${BUILD_VERSION} *.run

clean:
	rm -rf *.run

.PHONY: all build release pre-release clean