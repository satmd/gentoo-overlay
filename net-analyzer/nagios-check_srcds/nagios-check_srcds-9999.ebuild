# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="Check SRCDS servers using RCON"
HOMEPAGE="https://github.com/Azelphur-Servers/nagios-srcds-check"
EGIT_REPO_URI="https://github.com/Azelphur-Servers/nagios-srcds-check"
EGIT_COMMIT="73796af42be1583e89f9624021a2f2bb7bdb89a8"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-valve[${PYTHON_USEDEP}]"

src_compile() {
	sed -e 's,^from valve.source.rcon,from valve.rcon,' -i "${S}"/nagios-srcds-check.py
}

src_install() {
	mv nagios-srcds-check.py check_srcds
	exeinto /usr/$(get_libdir)/nagios/plugins
	doexe check_srcds
}
