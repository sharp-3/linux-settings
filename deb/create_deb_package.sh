#/bin/bash euxo pipefail-
LANG=C.UTF8
IFS='
'
LF='
'
pushd "$(dirname $0)" > /dev/null

pushd "$1" > /dev/null

fakeroot dpkg-deb --build root .

popd > /dev/null
popd > /dev/null
