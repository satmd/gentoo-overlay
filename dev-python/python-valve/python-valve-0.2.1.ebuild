# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 python3_8 )

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
	dev-python/docopt[${PYTHON_USEDEP}]
"
