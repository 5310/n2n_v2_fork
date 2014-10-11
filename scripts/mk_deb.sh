#!/bin/bash

# This script makes a Debian binary packages that can then be installed or shared.
# Of course, you'd need to make sure you have the build dependencies and GPG keys, etc.
#
# To run this script cd to the n2n directory and run it as follows
# scripts/mk_deb.sh
#
# To install all the built packages:
# sudo dpkg -i *.deb
#
# To build Debian source packages, use scripts/mk_deb-src.sh instead.
#

set -e

set -x

BASE=`pwd`

TARFILE=`${BASE}/scripts/mk_tar.sh`
TEMPDIR="build_deb"

test -f ${TARFILE}

echo "Building .deb"

if [ -d ${TEMPDIR} ]; then
    echo "Removing ${TEMPDIR} directory"
    rm -rf ${TEMPDIR} >&2
fi

mkdir ${TEMPDIR}

pushd ${TEMPDIR}

tar xzf ${TARFILE} #At original location

cd n2n*

dpkg-buildpackage -rfakeroot

popd

echo "Done"
