# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson udev

MY_P="${PN}-v${PV}"

DESCRIPTION="Library to add support for consumer fingerprint readers - add elanmoc2 driver"
HOMEPAGE="
	https://fprint.freedesktop.org/
	https://gitlab.freedesktop.org/libfprint/libfprint
"
SRC_URI="https://gitlab.com/tomoshibi1/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="~alpha amd64 arm arm64 ~loong ppc ppc64 ~riscv sparc x86"
IUSE="examples gtk-doc +introspection"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgudev
	dev-libs/nss
	dev-python/pygobject
	dev-libs/libgusb
	x11-libs/pixman
	examples? (
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3
	)
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	introspection? (
		dev-libs/gobject-introspection
		dev-libs/libgusb[introspection]
	)
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	# TODO: wire up test deps (cairo, pygobject, etc) for extra tests
	# currently skipped.
	local emesonargs=(
		$(meson_use examples gtk-examples)
		$(meson_use gtk-doc doc)
		$(meson_use introspection introspection)
		-Ddrivers=all
		-Dudev_rules=enabled
		-Dudev_rules_dir=$(get_udevdir)/rules.d
	)

	meson_src_configure
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

