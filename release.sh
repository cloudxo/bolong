#!/bin/bash

env NAME=$(basename $PWD) \
VERSION=$(git describe --tags | sed 's/^v//') \
GOVERSION=$(go version | cut -f3 -d' ') \
sh -c '
	CGO_ENABLED=0;
	mkdir local/${NAME}-${VERSION:-x} 2>/dev/null;
	SUFFIX=""
	if test $GOOS = windows; then
		SUFFIX=.exe
	fi
	DEST=local/${NAME}-${VERSION:-x}/${NAME}-${VERSION:-x}-${GOOS:-x}-${GOARCH:-x}-${GOVERSION:-x}${SUFFIX};
	go build -ldflags "-X main.version=${VERSION:-x}" &&
	mv ${NAME}${SUFFIX} $DEST &&
	ls -l $DEST
'
