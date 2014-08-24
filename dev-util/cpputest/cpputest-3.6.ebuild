# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cpptest/cpptest-1.1.2.ebuild,v 1.6 2012/12/16 15:14:49 armin76 Exp $

EAPI=4
inherit eutils

DESCRIPTION="unit testing framework for C++"
HOMEPAGE="http://cpputest.github.io"
SRC_URI="https://github.com/cpputest/cpputest.github.io/blob/master/releases/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""


src_configure() {
	econf
}

src_install() {
	default
	prune_libtool_files
}
