# Params for class devpi

class devpi::params {
  $user = 'devpi'
  $group = 'devpi'
  $package = 'devpi-server'
  $package_client = 'devpi-client'
  $service = 'devpi-server'
  $server_dir = '/opt/devpi'
  $proxy = undef

  case $::osfamily {
    'redhat': {
      $service_provider = $::operatingsystemmajrelease ? {
        /(5|6)/  => 'upstart',
        default  => 'systemd',
      }
      $systemd_directory = '/usr/lib/systemd/system/'
      $bin_directory = '/usr/bin/'
    }
    'debian': {
      $service_provider = $::operatingsystemmajrelease ? {
        /(6|7)/  => 'init',
        default  => 'systemd',
      }
      $systemd_directory = '/lib/systemd/system/'
      $bin_directory = '/usr/local/bin/'
    }
    default: {
      fail("Unsupported :osfamily ${::osfamily}")
    }
  }

}
