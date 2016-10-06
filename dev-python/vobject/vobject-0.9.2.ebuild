# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python3_4 )

inherit distutils-r1

DESCRIPTION="A full featured Python package for parsing and generating vCard and vCalendar files"
HOMEPAGE="https://eventable.github.io/vobject/ https://pypi.python.org/pypi/vobject"
SRC_URI="http://github.com/eventable/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/setuptools"[${PYTHON_USEDEP}]
DEPEND="${RDEPEND}"

DOCS=( ACKNOWLEDGEMENTS.txt )

python_test() {
	"${PYTHON}" test_vobject.py || die "Testing failed under ${EPYTHON}"
}
