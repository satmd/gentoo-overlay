# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python3_4 python3_5 )

inherit distutils-r1

DESCRIPTION="console carddav client"
HOMEPAGE="https://github.com/scheibler/khard/"
SRC_URI="https://github.com/scheibler/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="=dev-python/vobject-0.9.2[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/vdirsyncer[${PYTHON_USEDEP}]"

DOCS=( AUTHORS CHANGES README.md misc/khard/khard.conf.example )
