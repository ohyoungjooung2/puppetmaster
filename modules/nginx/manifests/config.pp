# Latest nginx for centos(maybe useful for redhat)
class nginx::config {
   file { "/etc/yum.repos.d/nginx.repo":
     ensure => present,
     owner => 'root',
     group => 'root',
     mode => 0600,
     source => "puppet:///modules/nginx/nginx.repo",
   }
}
