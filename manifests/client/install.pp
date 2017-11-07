class pptp::client::install {
  if $pptp::client_package_manage {
    package { $pptp::client_package_name:
      ensure => $pptp::client_package_ensure,
    }

    file { '/sbin/pon':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      seluser  => 'system_u',
      selrole  => 'object_r',
      seltype  => 'usr_t',
      selrange => 's0',
      content  => template('pptp/pon.erb'),
    }

    file { '/sbin/poff':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      seluser  => 'system_u',
      selrole  => 'object_r',
      seltype  => 'usr_t',
      selrange => 's0',
      content  => template('pptp/poff.erb'),
    }
  }

  if $pptp::client_module_manage {
    file { '/etc/modules-load.d/pptp.conf':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0644',
      seluser  => 'unconfined_u',
      seltype  => 'etc_t',
      selrange => 's0',
      selrole  => 'object_r',
      content  => "ppp_mppe\n",
    }

    exec { 'modprobe':
      command => 'modprobe ppp_mppe',
      path    => '/sbin/:/bin/',
      unless  => 'lsmod | egrep ^ppp_mppe',
    }
  }

  if $pptp::client_firewall_manage {
    include ::firewalld
    firewalld_direct_rule { 'Accept gre protocol':
      ensure        => present,
      inet_protocol => 'ipv4',
      table         => 'filter',
      chain         => 'INPUT',
      priority      => 0,
      args          => '-p gre -j ACCEPT',
    }
  }
}
