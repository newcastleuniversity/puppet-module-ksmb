class ksmb::config inherits ksmb {

  file { '/etc/systemd/system/cups.service' :
    ensure  => file,
    replace => true,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/${module_name}/cups.service",
    mode    => '0444',
    notify  => Service[$ksmb::service],
  }

  $ksmb::ppdfiles.each |$ppdfile| {

    file { "${ksmb::ppdpath}/${ppdfile}" :
      ensure  => file,
      replace => true,
      owner   => 'root',
      group   => 'root',
      source  => "${ksmb::ppdsource}/${ppdfile}",
      mode    => '0444',
      notify  => Service[$ksmb::service],
    }

  }

  $ksmb::filterfiles.each |$filterfile| {

    file { "${ksmb::filterpath}/${filterfile}" :
      ensure  => file,
      replace => true,
      owner   => 'root',
      group   => 'root',
      source  => "${ksmb::ppdsource}/${filterfile}",
      mode    => '0555',
      notify  => Service[$ksmb::service],
    }

  }

  file { '/etc/sudoers.d/lp' :
    ensure  => file,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => "lp ALL=(ALL,!root) NOPASSWD: /usr/lib/cups/backend/ksmb.real\n",
  }

  file { '/usr/lib/cups/backend/ksmb' :
    ensure  => file,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    content => "#!/bin/dash\nsudo -u \$2 /usr/lib/cups/backend/ksmb.real \$DEVICE_URI \"\$@\"\n",
  }

  file { '/usr/lib/cups/backend/ksmb.real' :
    ensure  => file,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    source  => "puppet:///modules/${module_name}/ksmb.real",
  }
  # See https://forge.puppet.com/leoarnold/cups#limitations for next stanza
  augeas { 'papersize':
    context => '/files/etc/default/locale',
    changes => 'set LC_PAPER \'"en_GB.UTF-8"\'' # Change to your locale
  }

}
