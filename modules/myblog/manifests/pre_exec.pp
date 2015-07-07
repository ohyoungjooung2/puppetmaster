class myblog::pre_exec inherits myblog::config {
     exec { "git_clone_myblog":
            cwd => "$rails_home",
            user => "$user",
            group => "$group",
            command => "mv $blog_dir $blog_dir_$(date +%y-%m-d-%H) && git clone $myblog_url",
            #unless => "ls -f $blog_dir",
           }   

     exec { "bundle_install_$blog_name":
            path => ["$ruby_path","/usr/bin","/bin","/sbin","/usr/sbin","/usr/local/bin"],
            #path => ["/home/rails4/.rubies/ruby-2.2.2/bin"]
            cwd => "$blog_home",
            user => "$user",
            group => "$group",
            command => "$ruby_path/gem install bundle && $ruby_path/bundle install && mkdir -p $blog_home/tmp/pids",
            require => Exec["git_clone_myblog"],
     }   

     exec { "rake_asset_compile":
            path => ["$ruby_path","/usr/bin","/bin","/sbin","/usr/sbin","/usr/local/bin"],
            user => "$user",
            group => "$group",
            cwd  => "$blog_home",
            command => "$ruby_path/rake assets:precompile RAILS_ENV=\"production\"",
            require => Exec["bundle_install_$blog_name"],
    }   
}
