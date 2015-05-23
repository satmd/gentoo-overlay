# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dunst/dunst-1.0.0-r1.ebuild,v 1.1 2014/05/08 05:59:22 wired Exp $

EAPI=5

inherit eutils

DESCRIPTION="customizable and lightweight notification-daemon"
HOMEPAGE="http://www.knopwob.org/dunst/"
SRC_URI="https://github.com/knopwob/${P}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dunstify"

CDEPEND="
	dev-libs/glib:2
	dev-libs/libxdg-basedir
	sys-apps/dbus
	x11-libs/libXScrnSaver
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/cairo[X,glib]
	x11-libs/pango[X]
	dunstify? ( x11-libs/libnotify )
"

DEPEND="${CDEPEND}
		dev-lang/perl
		virtual/pkgconfig"

RDEPEND="${CDEPEND}"

src_prepare() {

	# Remove nasty CFLAGS which override user choice
	sed -ie "/^CFLAGS/ {
		s:-g::
		s:-O.::
	}" config.mk || die "sed failed"

	if use dunstify; then
		sed -ie "/^all:/ s:\s*$: dunstify:" Makefile || die "sed failed"
	fi

	epatch_user
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install

	if use dunstify; then
		dobin dunstify
	fi

	dodoc CHANGELOG
}
