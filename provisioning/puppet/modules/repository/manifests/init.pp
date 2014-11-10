class repository {
  # We need cURL installed to import the key
  package { 'curl': ensure => installed }

  exec { "epel.repo":
    command => 'rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
    path    => ['/bin', '/usr/bin'],
    unless  => 'rpm -qa | grep epel',
  }

## uncomment to update your box
#  exec { 'yum-update':
#    path    => '/bin:/usr/bin',
#    command => 'yum update -y',
#  }
}
