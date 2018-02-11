#!/bin/sh
set -e

PORTSDIR="/usr/ports"
BUILD_DEPENDS="gtar-- py-sphinx"

while read line; do
    rm -rf "${PORTSDIR}/${line}"
done < overrides.txt
cp -R ports/* ${PORTSDIR}/

pkg_add ${BUILD_DEPENDS}
make -C ${PORTSDIR}/sysutils/ansible install clean
