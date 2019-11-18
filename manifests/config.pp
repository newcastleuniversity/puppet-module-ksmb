class ksmb::config inherits ksmb {

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
    content => "#!/bin/bash\nsudo -u \$2 /usr/lib/cups/backend/ksmb.real \$DEVICE_URI \"\$@\"\n",
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
    changes => "set LC_PAPER '\"${lcpaper}\"'"
  }

}
