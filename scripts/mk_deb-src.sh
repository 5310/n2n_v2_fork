#!/bin/bash

# This script makes a Debian source packages that can then be
# submitted to Launchpad PPA for automatic build and publication.
#
# Of course, you'd need to make sure you have the build dependencies and GPG keys, etc.
#
# To run this script cd to the n2n directory and run it as follows
# scripts/mk_deb-src.sh
#
# To submit to Launchpad PPA:
# dput ppa:username/ppaname ./build_deb/*.changes
#
# To build Debian packages directly, use scripts/mk_deb.sh instead.
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

debuild -S -sd

popd

echo "Done"
