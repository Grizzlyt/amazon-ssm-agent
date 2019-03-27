#!/usr/bin/env bash
echo "Run checkstyle script"

# run gofmt
echo "Run 'gofmt'"
unformatted=$(gofmt -l `pwd`/agent/)
if [[ -n $unformatted ]]; then
	echo >&2 "Found files not formatted by gofmt"
	for fi in $unformatted; do
		echo "Running 'gofmt -w' for $fi file"
		gofmt -w $fi
	done
fi

# run goimports
echo "Try update 'goimports'"
GOPATH=`pwd`/Tools go get golang.org/x/tools/cmd/goimports

echo "Run 'goimports'"
unformatted=$(Tools/bin/goimports -l `pwd`/agent/)
if [[ -n $unformatted ]]; then
	echo >&2 "Found files not formatted by goimports"
	for f in $unformatted; do
		"Running 'goimports -w' for $f file"
		./Tools/bin/goimports -w $f
	done
fi

echo "Run 'go vet'"
go tool vet `pwd`/agent
