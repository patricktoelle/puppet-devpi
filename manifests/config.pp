# Configures devpi
class devpi::config (
  $user        = $::devpi::user,
  $group       = $::devpi::group,
  $listen_host = $::devpi::listen_host,
  $listen_port = $::devpi::listen_port,
  $server_dir  = $::devpi::server_dir,
  $virtualenv  = $::devpi::virtualenv,
  $proxy       = $::devpi::proxy,
) inherits ::devpi::params {

  if $::devpi::params::service_provider == 'systemd' {
    $devpi_path = $virtualenv ? {
      '' => "${::devpi::params::bin_directory}/devpi-server",
      default => "${virtualenv}bin/devpi-server"
    }
    file {
      "${::devpi::params::systemd_directory}${::devpi::service_name}.service":
        ensure  => $::devpi::ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/systemd.service.erb"),
    }
  } else {
    file { "/etc/init/${::devpi::service_name}.conf":
      ensure  => $::devpi::ensure,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/upstart.erb"),
    }
  }
}
