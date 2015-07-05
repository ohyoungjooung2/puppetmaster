class myblog::blog_config inherits myblog::config {
     file { "$blog_config/$unicorn":
          ensure => present,
          owner => "$user",
          group => "$group",
          mode => 0600,
          source => "puppet:///modules/myblog/$unicorn",
          require => Exec["db_setup"],
     }

     file { "$blog_config/$unicorn_start_sh":
          ensure => present,
          owner => "$user",
          group => "$group",
          mode => 0755,
          source => "puppet:///modules/myblog/$unicorn_start_sh",
          require => File["$blog_config/$unicorn"],
     }

}
