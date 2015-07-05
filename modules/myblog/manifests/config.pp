class myblog::config inherits rails4::ruby_compile {
     #Puppet deploying rails4.2.1 application
     $user="$rails_user"
     $group="$rails_group"
     $rails_home="$rails_home"
     $blog_name="myblog"
     $blog_home="$rails_home/$blog_name"
     $blog_dir="$rails_home/$blog_name"
     $myblog_url= "https://github.com/ohyoungjooung2/myblog.git"
     $blog_config="$blog_dir/config"
     $unicorn="unicorn.rb"
     $unicorn_start_sh="unicorn_init.sh"
}
