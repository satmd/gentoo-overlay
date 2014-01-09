# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Simple kernel upgrade/cleanup tools"
HOMEPAGE="none"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-boot/grub:2 sys-kernel/dracut virtual/linux-sources"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
}

src_install() {
	exeinto /etc/kernel/postinst.d/
	doexe "${FILESDIR}"/10-permissions.sh
	doexe "${FILESDIR}"/30-modules-paludis.sh
	doexe "${FILESDIR}"/80-dracut.sh
	doexe "${FILESDIR}"/90-grub-mkconfig.sh

	insinto /usr/bin
	dobin "${FILESDIR}"/kernel-cleanup
	dobin "${FILESDIR}"/kernel-upgrade
}
