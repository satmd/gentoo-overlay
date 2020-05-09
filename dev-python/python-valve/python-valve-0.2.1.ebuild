# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 python3_4 python3_5 python3_6 python3_7 python3_8)

inherit distutils-r1

DESCRIPTION="A Python Interface to various Valve products and services"
HOMEPAGE="https://github.com/serverstf/python-valve"
SRC_URI="https://github.com/serverstf/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"
LICENSE="python-valve"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
DEPEND="
	dev-python/monotonic[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
"
