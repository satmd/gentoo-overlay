# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_3 python3_4 python3_5 python3_6)

inherit multilib python-r1

DESCRIPTION="A remote security scanner for Linux (extra tools)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="https://github.com/greenbone/gvm-tools/archive/v${PV}.tar.gz -> openvas-tools-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}"/gvm-tools-${PV}
