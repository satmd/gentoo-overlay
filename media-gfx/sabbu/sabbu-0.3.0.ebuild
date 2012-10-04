# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils

DESCRIPTION="Subtitle script creator/editor"
HOMEPAGE="http://www.sabbu.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ffmpeg nls oss"

RDEPEND="ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20051120 )
		>=x11-libs/gtk+-2.6
		media-libs/libsndfile"
DEPEND="${RDEPEND}
		nls? ( sys-devel/gettext )"

src_unpack() {
		unpack ${A} ; cd "${S}"
		epatch "${FILESDIR}/${P}-new-ffmpeg.patch"
}

src_compile() {
		econf $(use_with ffmpeg) \
			  $(use_enable nls) \
			  $(use_with oss) || die "configure failed"
		emake || die "make failed"
}

src_install() {
		make install DESTDIR="${D}" || die "install failed"
		dodoc AUTHORS ChangeLog NEWS README
}
