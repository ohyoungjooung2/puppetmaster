class myblog  {

     #myblog rails application deployment
     include myblog::required_pkg 
     include myblog::pre_exec
     include myblog::db_config
     include myblog::blog_config
     include myblog::unicorn_init


  



  
     #Nginx default virtual host and restart
     file { "/etc/nginx/conf.d/default.conf":
         ensure => present,
         owner => "root",
         group => "root",
         mode => 0644,      
         content => template("myblog/nginx_default.conf.erb"),
         notify  => Service[nginx],
         require => Exec["start_unicorn"],

     }

}
