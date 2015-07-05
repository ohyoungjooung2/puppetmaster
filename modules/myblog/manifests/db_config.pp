class myblog::db_config inherits myblog::config {
     file {"$blog_config/database.yml":
          ensure => present,
          owner => "$user",
          group => "$group",
          mode => 0600,
          source => "puppet:///modules/myblog/database.yml",
          require => Exec["rake_asset_compile"],
     }


     exec { "db_setup":
          path => ["$ruby_path","/usr/bin","/bin","/sbin","/usr/sbin","/usr/local/bin"],
          user => "$user",
          cwd  => "$blog_home",
          group => "$group",
          command => "$ruby_path/rake db:setup RAILS_ENV=\"production\"",
          require => File["$blog_config/database.yml"],
     }

}
