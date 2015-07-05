class myblog::unicorn_init inherits myblog::config {
#unicorn start
     exec { "start_unicorn":
          path => ["$ruby_path","$blog_config","/usr/bin","/bin","/sbin","/usr/sbin","/usr/local/bin"],
          cwd  => "$blog_config",
          user => "$user",
          group => "$group",
          command => "./$unicorn_start_sh start",
          require => File["$blog_config/$unicorn_start_sh"],
     }
}
