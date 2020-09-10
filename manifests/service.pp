# Class: minio::service
# ===========================
#
# Manages services for the `::minio` class.
#
# Parameters
# ----------
#
# * `manage_service`
# Should we manage a service definition for Minio?
#
# * `service_provider`
# Which service provider do we use?
#
# Authors
# -------
#
# Daniel S. Reichenbach <daniel@kogitoapp.com>
#
# Copyright
# ---------
#
# Copyright 2017 Daniel S. Reichenbach <https://kogitoapp.com>
#
class minio::service (
  Boolean $manage_service  = $minio::manage_service,
  String $service_provider = $minio::service_provider,
  String $configuration_directory = $minio::configuration_directory
  ) {

  if ($manage_service) {
    file { '/etc/minio/config.env':
      ensure  => file,
      content => template('minio/config.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      require => File[$configuration_directory],
    }

    service { 'minio':
      ensure     => 'running',
      enable     => true,
      hasstatus  => false,
      hasrestart => false,
      provider   => $service_provider,
      subscribe  => Remote_File['minio'],
      require    => File['/etc/minio/config.env'],
    }
  }
}
