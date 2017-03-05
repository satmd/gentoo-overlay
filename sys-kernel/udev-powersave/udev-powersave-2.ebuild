# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Simple powersave settings collection"
HOMEPAGE="https://github.com/satmd/gentoo-overlay"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/udev sys-apps/hdparm"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
}

src_install() {
	exeinto /lib/udev
	doexe "${FILESDIR}"/udev-hdparm

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/90-hdparm.rules
	doins "${FILESDIR}"/90-powermanagement-runtime.rules
	doins "${FILESDIR}"/90-powermanagement-sata.rules
	doins "${FILESDIR}"/90-rfkill.rules

}
