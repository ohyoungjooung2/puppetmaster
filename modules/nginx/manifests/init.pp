class nginx {
case $::operatingsystem {
   'RedHat', 'CentOS', 'Scientific', 'OracleLinux', 'OEL': {
     include nginx::config
     # do something RHEL specific
     # execute 'yum update'
     exec { 'yum-update':
       command => '/bin/yum -y update'
     }
     exec { 'yum-nginx-pcre':
       command => '/bin/yum -y install pcre-devel',
       require => Exec['yum-update']
     }
     #install nginx ensure
     package { 'nginx':
      ensure => installed,
     }
     #running service
     service { 'nginx':
     ensure => running,
     }
   }


   'ubuntu': {
     #inlcude ubuntu_config is for running latest nginx version from nginx.org apt-repo
     #When we do not want to install latest nginx package,just comment include line
     include nginx::ubuntu_config
     # execute 'apt-get update'
     exec { 'apt-update-for-latest-nginx':                    # exec resource named 'apt-update'
     command => '/usr/bin/apt-get update'  # command this resource will run
     }


     package { 'nginx':
      ensure => latest,
     }
      # running nginx
     service { 'nginx':
     ensure => running,
     }
    
   }
   default: {
     # ...
   }
 }
}
