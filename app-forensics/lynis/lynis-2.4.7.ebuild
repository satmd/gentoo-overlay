# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils bash-completion-r1

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://cisofy.com/lynis/"
SRC_URI="http://cisofy.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cron"

DEPEND=""
RDEPEND="app-shells/bash"

S="${WORKDIR}/${PN}"

src_prepare() {
	# Bug 507438
	epatch_user
}

src_install() {
	doman lynis.8
	dodoc CHANGELOG.md FAQ README

	# Remove the old one during the next stabilize progress
	if use cron ; then
		exeinto /etc/cron.daily
		newexe "${FILESDIR}"/lynis.cron-new lynis
	fi

	dobashcomp extras/bash_completion.d/lynis

	# stricter default perms - bug 507436
	diropts -m0700
	insopts -m0600

	insinto /usr/share/${PN}
	doins -r db/ include/ plugins/

	dosbin lynis

	insinto /etc/${PN}
	doins default.prf
}

pkg_postinst() {
	if use cron ; then
		einfo
		einfo "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
		einfo
	fi
}
