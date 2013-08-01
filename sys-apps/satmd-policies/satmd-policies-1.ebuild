# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="satmd provides sane system security policies"
HOMEPAGE="none"
SRC_URI=""

LICENSE="as-is"
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
