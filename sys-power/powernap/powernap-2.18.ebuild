# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils python-r1

DESCRIPTION="Ubuntu's Powernap server power management tools"
HOMEPAGE="https://launchpad.net/powernap"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
		sys-power/pm-utils
		sys-apps/net-tools"

src_install() {
	python_export python2_7 EPYTHON PYTHON PYTHON_SITEDIR
	
	# install the powernap python package
	python_domodule powernap

	# install in /usr/bin script
	python_doscript bin/powernap_calculator

	# install in /usr/sbin script
	python_scriptinto /usr/sbin
	python_doscript sbin/powernap-action
	python_doscript sbin/powernapd

	dosbin sbin/powernap || die
	dosbin sbin/powernap-now || die

	dodir /etc/powernap || die
	insinto /etc/powernap || die
	doins config || die
	doins action || die

	doman man/powernap* || die
}

pkg_postinst() {
	elog "Edit /etc/powernap/config and /etc/powernap/action"
	elog "to define the monitors to use and the actions to do"
}
