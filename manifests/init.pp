# Class: ksmb
# ===========================
#
# Full description of class ksmb here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'ksmb':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#

class ksmb (

  Optional[String] $ppdpath = lookup('ksmb::ppdpath'),
  Optional[String] $ppdsource = lookup('ksmb::ppdsourc'),
  Optional[Array[String]] $ppdfiles = lookup('ksmb::ppdfiles'),
  Optional[Array[String]] $package_list = lookup('ksmb::package_list'),
  Optional[String] $service = lookup('ksmb::service')

){

  anchor { '::ksmb::begin': } ->
  class { '::ksmb::install': } ~>
  class { '::ksmb::config': } ->
  anchor { '::ksmb::end': }

}
