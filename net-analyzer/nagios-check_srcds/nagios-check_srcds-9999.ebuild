# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Check SRCDS servers using RCON"
HOMEPAGE="https://github.com/Azelphur-Servers/nagios-srcds-check - forked"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-valve[${PYTHON_USEDEP}]"

src_compile() {
	cp "${FILESDIR}/check_srcds-${PV}" "${S}/check_srcds"
}

src_install() {
	exeinto /usr/$(get_libdir)/nagios/plugins
	doexe check_srcds
}
