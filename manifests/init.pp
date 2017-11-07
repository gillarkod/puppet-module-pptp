# Class: pptp
# ===========
#
# Manage pptp and connections
#
class pptp (
  Boolean $client_package_manage,
  Enum['present','installed','absent','purged','held','latest'] $client_package_ensure,
  String $client_package_name,
  Boolean $client_module_manage,
  Array[Struct[{name => String, ip => String, route => String, username => String, password => String, running => Boolean, enable => Boolean}]] $connections,
  Boolean $client_firewall_manage,
) {
  include pptp::client::install
  include pptp::client::service
  include pptp::client::connections
  Class['pptp::client::install'] -> Class['pptp::client::service'] -> Class['pptp::client::connections']
}
