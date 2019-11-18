# install a ksmb backend for kerberised printing

class ksmb (

  Optional[Array[String]] $package_list = ['smbclient'],
  Optional[String] $lcpaper             = 'en_GB.UTF-8'

){

  anchor { '::ksmb::begin': }
  -> class { '::ksmb::install': }
  ~> class { '::ksmb::config': }
  -> anchor { '::ksmb::end': }

}
