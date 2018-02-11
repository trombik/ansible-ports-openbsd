#!/bin/sh
set -e

PREFIX="/usr"
PORTSDIR="${PREFIX}/ports"
BUILD_DEPENDS="gtar-- py-sphinx"

case `uname -r` in
    6.0)
        installurl=`grep -E '^installpath' /etc/pkg.conf | sed -e 's/^.*=[[:space:]]*//'`
        ;;
    *)
        installurl=`cat /etc/installurl`
        ;;
esac
ftp -o - ${installurl}/`uname -r`/ports.tar.gz | tar -C ${PREFIX} -zxf -
while read line; do
    rm -rf "${PORTSDIR}/${line}"
done < overrides.txt
cp -R ports/* ${PORTSDIR}/

pkg_add ${BUILD_DEPENDS}
make -C ${PORTSDIR}/sysutils/ansible install clean
