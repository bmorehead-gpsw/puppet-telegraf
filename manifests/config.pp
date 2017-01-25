# == Class: telegraf::config
#
# Templated generation of telegraf.conf
#
class telegraf::config inherits telegraf {

  assert_private()

  exec { 'remove default configfile':
    command => 'rm -f /etc/telegraf/telegraf.conf',
    path    => '/usr/bin:/usr/sbin:/bin',
    onlyif  => "file -i /etc/telegraf/telegraf.conf | grep -i utf-8", 
  } ->
  file { $::telegraf::config_file:
    ensure  => file,
    content => template('telegraf/telegraf.conf.erb'),
    mode    => '0640',
    owner   => 'telegraf',
    group   => 'telegraf',
    notify  => Class['::telegraf::service'],
    require => Class['::telegraf::install'],
  }

}
