# Installs devpi service
class devpi::service {

  service { $::devpi::service_name:
    ensure   => $::devpi::service_ensure,
    enable   => $::devpi::service_enable,
    provider => $::devpi::params::service_provider,
  }

}
