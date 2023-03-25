#/bin/bash euxo pipefail-
LANG=C.UTF8
IFS='
'
LF='
'
pushd "$(dirname $0)" > /dev/null

pushd "$1/root" > /dev/null

du -k .

popd > /dev/null
popd > /dev/null
