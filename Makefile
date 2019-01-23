VERSION := $(shell git describe --tags --always --dirty="-dev")


all: dist/ssm-get-parameter-$(VERSION)-darwin-amd64
all: dist/ssm-get-parameter-$(VERSION)-linux-amd64
all: dist/ssm-get-parameter-$(VERSION)-windows-amd64.exe

dist/:
	mkdir -p dist

dist/ssm-get-parameter-$(VERSION)-darwin-amd64: | dist/
	GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 GO111MODULE=on go build $(LDFLAGS) -o $@

dist/ssm-get-parameter-$(VERSION)-linux-amd64: | dist/
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GO111MODULE=on go build $(LDFLAGS) -o $@

dist/ssm-get-parameter-$(VERSION)-windows-amd64.exe: | dist/
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0 GO111MODULE=on go build $(LDFLAGS) -o $@
