# == Class: telegraf::config
#
# Templated generation of telegraf.conf
#
class telegraf::config inherits telegraf {

  assert_private()

  exec { 'remove default configfile':
    command => 'rm -f /etc/telegraf/telegraf.conf',
    path    => '/usr/bin:/usr/sbin:/bin',
    onlyif  => "echo 'fcc58c3cf9efa1a34f0db4bf5eba6ea7  /etc/telegraf/telegraf.conf' | md5sum -c --status",
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
