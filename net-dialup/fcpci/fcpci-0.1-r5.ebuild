# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils rpm linux-mod

DESCRIPTION="AVM kernel 2.6/3.0 modules for Fritz!Card PCI"
HOMEPAGE="http://opensuse.foehr-it.de/"
SRC_URI="http://opensuse.foehr-it.de/rpms/11_2/src/${P}-0.src.rpm"
RESTRICT="nomirror"

LICENSE="AVM-FC"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

DEPEND="!net-dialup/fritzcapi"
RDEPEND="${DEPEND} net-dialup/capi4k-utils"

S="${WORKDIR}/fritz"

pkg_setup() {
	linux-mod_pkg_setup

	if ! kernel_is 2 6; then
		if ! kernel_is 3 0; then
			die "This package works only with 2.6 or 3.0 kernel!"
		fi
	fi

	BUILD_TARGETS="all"
	BUILD_PARAMS="KDIR=${KV_DIR} LIBDIR=${S}/src"
	MODULE_NAMES="${PN}(net:${S}/src)"
}

src_unpack() {
	local BIT="" PAT="01234567"
	if use amd64; then
		BIT="64bit-" PAT="1234"
	fi

	rpm_unpack "${A}" || die "failed to unpack ${A} file"
	DISTDIR="${WORKDIR}" unpack ${PN}-suse[0-9][0-9]-${BIT}[0-9].[0-9]*-[0-9]*.tar.gz

	cd "${S}"
	epatch $(sed -n "s|^Patch[${PAT}]:\s*\(.*\)|../\1|p" ../${PN}.spec)
	convert_to_m src/Makefile

	for i in lib/*-lib.o; do
		einfo "Localize symbols in ${i##*/} ..."
		objcopy -L memcmp -L memcpy -L memmove -L memset -L strcat \
			-L strcmp -L strcpy -L strlen -L strncmp -L strncpy "${i}"
	done

	sed -i "s#/var/lib/fritz#${WORKDIR}/fritz/lib#" src/Makefile

	cd "${S}/src"
	epatch ${FILESDIR}/kernel-2.6.34.patch
	epatch ${FILESDIR}/kernel-2.6.39.patch
}

src_install() {
	linux-mod_src_install
	dodoc CAPI*.txt
	dohtml *.html
}
