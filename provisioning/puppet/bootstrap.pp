if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}
stage { setup: before => Stage[main] }
class { 'repository':
  # Forces the repository to be configured before any other task
  stage => setup
}
