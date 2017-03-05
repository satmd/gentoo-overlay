# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="satmd provides sane system security policies"
HOMEPAGE="https://github.com/satmd/gentoo-overlay"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
}

src_install() {
	insinto /etc/sysctl.d
	doins "${FILESDIR}"/sysctl.d/satmd-grsecurity.conf
	doins "${FILESDIR}"/sysctl.d/satmd-security.conf

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/rules.d/50-satmd-security.rules
}
