# install a ksmb backend for kerberised printing

class ksmb (

  Optional[String] $ppdpath             = '/usr/share/cups/model',
  Optional[String] $ppdsource           = 'puppet:///modules/ksmb/ppds',
  Optional[Array[String]] $ppdfiles     = ['KOC658UX.ppd'],
  Optional[Array[String]] $package_list = ['smbclient'],
  Optional[String] $service             = 'cups'

){

  anchor { '::ksmb::begin': }
  -> class { '::ksmb::install': }
  ~> class { '::ksmb::config': }
  -> anchor { '::ksmb::end': }

}
