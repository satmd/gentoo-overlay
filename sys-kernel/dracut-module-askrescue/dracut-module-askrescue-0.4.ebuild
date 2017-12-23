# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="The kernel install makefile and companions of satmd"
HOMEPAGE="https://git.satmd.de/satmd/linux/dracut-module-askrescue"
SRC_URI="https://git.satmd.de/satmd/linux/${PN}/snapshot/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-kernel/dracut"
