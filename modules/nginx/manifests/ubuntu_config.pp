class nginx::ubuntu_config {
   file { "/etc/apt/sources.list.d/nginx.list":
     ensure => present,
     owner => 'root',
     group => 'root',
     mode => 0600,
     source => "puppet:///modules/nginx/nginx.ulist",
   }

   file { "/tmp/nginx_signing.key":
          ensure => present,
          owner => 'root',
          group => 'root',
          mode => 0600,
          source => "puppet:///modules/nginx/nginx_signing.key",
    }

   exec {'key-add':
     command => '/usr/bin/apt-key add /tmp/nginx_signing.key'
   }
   #removing ubuntu repo's nginx packages
   exec {'remove-pre-nginx':
     command => '/usr/bin/apt-get -y remove --purge nginx nginx-common nginx-core'
   }
   #$nginx_pkgs = ["nginx","nginx-common","nginx-core"]
   #package { $nginx_pkgs: ensure => "absent" }
    
}
