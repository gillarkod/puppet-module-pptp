class pptp::client::service {
  file { 'ppp.service':
    ensure   => 'file',
    path     => '/etc/systemd/system/ppp@.service',
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    seluser  => 'unconfined_u',
    seltype  => 'iptables_unit_file_t',
    selrange => 's0',
    selrole  => 'object_r',
    content  => template('pptp/service.erb'),
    notify   => Exec['daemon-reload'],
  }

  exec { 'daemon-reload':
    command     => 'systemctl daemon-reload',
    path        => '/bin/',
    refreshonly => true,
  }
}
