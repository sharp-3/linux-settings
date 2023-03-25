#/bin/bash euxo pipefail-
LANG=C.UTF8
IFS='
'
LF='
'
pushd "$(dirname $0)" > /dev/null

pushd "$1/root" > /dev/null

files=$(find . -type f)

echo -n "" > DEBIAN/md5sums

for file in ${files}; do
	if [ "./DEBIAN/control" = "${file}" ]; then
		echo -n ""
	elif [ "./DEBIAN/md5sums" = "${file}" ]; then
		echo -n ""
	else
		md5sum ${file} >> DEBIAN/md5sums
	fi
done

ls -l DEBIAN/md5sums
cat DEBIAN/md5sums

popd > /dev/null
popd > /dev/null
