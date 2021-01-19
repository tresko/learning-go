#!/bin/sh
set -e

readonly type="$1"
readonly service="$2"
path=""

if [ $type == "pkg" ]
then
   path="pkg"
else
   path="microservices"
fi

cd "./$path/$service"
go test ./... -v
