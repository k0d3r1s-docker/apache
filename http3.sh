#!/bin/sh

cd ./source || exit
git reset --hard
git pull
VERSION=`git rev-parse --short HEAD`

cd .. || exit

rm -rf src
cp -r source src
rm -rf src/.git src/.github

docker build --tag k0d3r1s/apache:ah3-${VERSION} --tag k0d3r1s/apache:ah3-latest --squash --compress --no-cache -f Dockerfile.http3 --build-arg version=${VERSION} . || exit

rm -rf src

old=`cat latest3`
hub-tool tag rm k0d3r1s/apache:ah3-$old -f
echo -n $VERSION > latest3

docker push k0d3r1s/apache:ah3-${VERSION}
docker push k0d3r1s/apache:ah3-latest