class myblog  {
     #Puppet deploying rails4.2.1 application 
#     $user="$rails_user"
#     $group="$rails_group"
#     $rails_home="$rails_home"
#     $blog_name="myblog"
#     $blog_home="$rails_home/$blog_name"
#     $blog_dir="$rails_home/$blog_name"
#     $myblog_url= "https://github.com/ohyoungjooung2/myblog.git"
#     $blog_config="$blog_dir/config"
#     $unicorn="unicorn.rb"
#     $unicorn_start_sh="unicorn_init.sh"

     include myblog::required_pkg 
     include myblog::pre_exec
     include myblog::db_config
     include myblog::blog_config
     include myblog::unicorn_init


  



  
     #Nginx default virtual host
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
