# install a ksmb backend for kerberised printing

class ksmb (

  Optional[Array[String]] $package_list = ['smbclient'],
  Optional[Stdlib::Unixpath] $backend   = '/usr/lib/cups/backend',
  Optional[String] $lcpaper             = 'en_GB.UTF-8'

){

  $ksmb::package_list.each |$package| {

    package { $package: }

  }

  file { '/etc/sudoers.d/lp' :
    ensure  => file,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => "lp ALL=(ALL,!root) NOPASSWD: ${backend}/ksmb.real\n",
  }

  file { 'ksmb' :
    ensure  => file,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    path    => "${backend}/ksmb",
    content => "#!/bin/bash\nsudo -u \$2 ${backend}/ksmb.real \$DEVICE_URI \"\$@\"\n",
  }

  file { 'ksmb.real' :
    ensure  => file,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    path    => "${backend}/ksmb.real",
    source  => "puppet:///modules/${module_name}/ksmb.real",
  }
  # See https://forge.puppet.com/leoarnold/cups#limitations for next stanza
  augeas { 'papersize':
    context => '/files/etc/default/locale',
    changes => "set LC_PAPER '\"${lcpaper}\"'"
  }

}
