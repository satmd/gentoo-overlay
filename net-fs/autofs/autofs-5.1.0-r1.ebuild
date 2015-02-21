# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-5.1.0.ebuild,v 1.2 2014/06/14 15:29:00 dlan Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true
AUTOTOOLS_IN_SOURCE_BUILD=true

inherit autotools-utils linux-info multilib systemd toolchain-funcs

DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI="
	mirror://kernel/linux/daemons/${PN}/v5/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="-dmalloc hesiod ldap libtirpc mount-locking sasl"

# USE="sasl" adds SASL support to the LDAP module which will not be build. If
# SASL support should be available, please add "ldap" to the USE flags.
REQUIRED_USE="sasl? ( ldap )"

# currently, sasl code assumes the presence of kerberosV
RDEPEND=">=sys-apps/util-linux-2.20
	dmalloc? ( dev-libs/dmalloc[threads] )
	hesiod? ( net-dns/hesiod )
	ldap? ( >=net-nds/openldap-2.0
		sasl? (
			dev-libs/cyrus-sasl
			dev-libs/libxml2
			virtual/krb5
		)
	)
	libtirpc? ( net-libs/libtirpc )"

DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc"

CONFIG_CHECK="~AUTOFS4_FS"

PATCHES=(
	"${FILESDIR}/${P}-fix-missing-stdarg.patch"
)

src_prepare() {
	# Upstream's patchset
	PATCHES="
		autofs-5.1.0-fix-compile-error-in-defaults_c.patch
		autofs-5.1.0-add-serialization-to-sasl-init.patch
		autofs-5.1.0-dont-allocate-dev_ctl_ops-too-early.patch
		autofs-5.1.0-fix-incorrect-round-robin-host-detection.patch
		autofs-5.0.9-fix-race-accessing-qdn-in-get_query_dn.patch
		autofs-5.1.0-fix-leak-in-cache_push_mapent.patch
		autofs-5.1.0-fix-config-entry-read-buffer-not-checked.patch
		autofs-5.1.0-fix-FILE-pointer-check-in-defaults_read_config.patch
		autofs-5.1.0-fix-memory-leak-in-conf_amd_get_log_options.patch
		autofs-5.1.0-fix-signed-comparison-in-inet_fill_net.patch
		autofs-5.1.0-fix-buffer-size-checks-in-get_network_proximity.patch
		autofs-5.1.0-fix-leak-in-get_network_proximity.patch
		autofs-5.1.0-fix-buffer-size-checks-in-merge_options.patch
		autofs-5.1.0-check-amd-lex-buffer-len-before-copy.patch
		autofs-5.1.0-add-return-check-in-ldap-check_map_indirect.patch
		autofs-5.1.0-check-host-macro-is-set-before-use.patch
		autofs-5.1.0-check-options-length-before-use-in-parse_amd_c.patch
		autofs-5.1.0-fix-some-out-of-order-evaluations-in-parse_amd_c.patch
		autofs-5.1.0-fix-copy-and-paste-error-in-dup_defaults_entry.patch
		autofs-5.1.0-fix-leak-in-parse_mount.patch
		autofs-5.1.0-add-mutex-call-return-check-in-defaults_c.patch
		autofs-5.1.0-force-disable-browse-mode-for-amd-format-maps.patch
		autofs-5.1.0-fix-hosts-map-options-check-in-lookup_amd_instance.patch
		autofs-5.1.0-fix-mem-leak-in-create_client.patch
		autofs-5.1.0-fix-memory-leak-in-get_exports.patch
		autofs-5.1.0-fix-memory-leak-in-get_defaults_entry.patch
		autofs-5.1.0-fix-out-of-order-clearing-of-options-buffer.patch
		autofs-5.1.0-fix-reset-amd-lexer-scan-buffer.patch
		autofs-5.1.0-ignore-multiple-commas-in-options-strings.patch
		autofs-5.1.0-fix-typo-in-flagdir-configure-option.patch
		autofs-5.1.0-clarify-multiple-mounts-description.patch
		autofs-5.1.0-gaurd-against-incorrect-umount-return.patch
		autofs-5.1.0-update-man-page-autofs-8-for-systemd.patch
"
	for PATCH in $PATCHES ; do
		epatch "${FILESDIR}/${PATCH}"
	done
	sed -i -e "s:/usr/bin/kill:/bin/kill:" samples/autofs.service.in || die #bug #479492
	autotools-utils_src_prepare
}

src_configure() {
	# bug #483716
	tc-export AR
	# --with-confdir is for bug #361481
	# --with-mapdir is for bug #385113
	local myeconfargs=(
		--with-confdir=/etc/conf.d
		--with-mapdir=/etc/autofs
		$(use_with dmalloc)
		$(use_with ldap openldap)
		$(use_with libtirpc)
		$(use_with sasl)
		$(use_with hesiod)
		$(use_enable mount-locking)
		--disable-ext-env
		--enable-sloppy-mount # bug #453778
		--enable-force-shutdown
		--enable-ignore-busy
		--with-systemd="$(systemd_get_unitdir)" #bug #479492
		RANLIB="$(type -P $(tc-getRANLIB))" # bug #483716
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile DONTSTRIP=1
}

src_install() {
	autotools-utils_src_install

	if kernel_is -lt 2 6 30; then
		# kernel patches
		docinto patches
		dodoc patches/${PN}4-2.6.??{,.?{,?}}-v5-update-????????.patch
	fi
	newinitd "${FILESDIR}"/autofs5.initd autofs
	insinto etc/autofs
	newins "${FILESDIR}"/autofs5-auto.master auto.master
}

pkg_postinst() {
	if kernel_is -lt 2 6 30; then
		elog "This version of ${PN} requires a kernel with autofs4 supporting"
		elog "protocol version 5.00. Patches for kernels older than 2.6.30 have"
		elog "been installed into"
		elog "${EROOT}usr/share/doc/${P}/patches."
		elog "For further instructions how to patch the kernel, please refer to"
		elog "${EROOT}usr/share/doc/${P}/INSTALL."
		elog
	fi
	elog "If you plan on using autofs for automounting remote NFS mounts,"
	elog "please check that both portmap (or rpcbind) and rpc.statd/lockd"
	elog "are running."
}
