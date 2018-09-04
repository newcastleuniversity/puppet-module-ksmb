class ksmb::install inherits ksmb {

  $::ksmb::package_list.each |$package| {

    package { $package: }

  }

}
