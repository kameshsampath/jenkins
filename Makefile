SKIP_SQUASH?=0
# The master images follow the normal numbering scheme in which the
# major version is used as the directory name and incorporated into
# the image name (jenkins-1-centos7 in this case).  For the slave
# images we are not versioning them (they actually pull their
# jars from the jenkins master, so they don't have a jenkins version,
# so the only thing we'd version is the maven/nodejs version).
# Since these are basically samples we are just going to maintain one
# version (at least that is the initial goal).  This naming system
# can be revisited in the future if we decide we need either jenkins
# or <platform> version numbers in the names.
VERSIONS="1 slave-base slave-maven slave-nodejs"

ifeq ($(TARGET),rhel7)
	OS := rhel7
else
	OS := centos7
endif

ifeq ($(VERSION), 1)
	VERSION := 1
else
	VERSION :=
endif

.PHONY: build
build:
	SKIP_SQUASH=$(SKIP_SQUASH) VERSIONS=$(VERSIONS) hack/build.sh $(OS) $(VERSION)

.PHONY: test
test:
	SKIP_SQUASH=$(SKIP_SQUASH) VERSIONS=$(VERSIONS) TAG_ON_SUCCESS=$(TAG_ON_SUCCESS) TEST_MODE=true hack/build.sh $(OS) $(VERSION)
