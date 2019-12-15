#!/usr/bin/env sh

mkdir -p ${GOPATH}/src/github.com/mytheta/go-concourse
cp -r go-concourse-src/* ${GOPATH}/src/github.com/mytheta/go-concourse
go get -u golang.org/x/lint/golint
cd ${GOPATH}/src/github.com/mytheta/go-concourse
export GO111MODULE=on
echo "build start"
CGO_ENABLED=1 GOOS=linux go build main.go
echo "lint start"
lint=$(go list ./... | grep -v /vendor/ | xargs -L1 golint -set_exit_status)
if [ -n "${lint}" ]
then
  echo "${lint}"
  exit 1
fi
echo "test start"
go test -cover $(go list ./...)

