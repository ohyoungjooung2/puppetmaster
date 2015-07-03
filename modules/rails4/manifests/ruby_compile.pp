class rails4::ruby_compile {
     #rails varialbles
     $rails_user="rails4"
     $rails_group="rails4"
     $rails_home="/home/$rails_user"
     $compile_dir="$rails_home/compile"
     $ruby_version="ruby-2.2.2"
     $config_dir="$compile_dir/$ruby_version"
     $ext="tar.gz"
     $ruby_source="$ruby_version.$ext"
     $ruby_dir="$rails_home/.rubies"
     $ruby_each_home="$ruby_dir/$ruby_version"
     $ruby_path="$ruby_each_home/bin"

     #$ruby_url="http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p645.tar.gz"
     #$ruby_url="http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz"
     $ruby_url="http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz"


     exec { "mkdir_$compile_dir":
        path => ['/bin','/usr/bin','/usr/sbin','/sbin'],
        cwd => $rails_home,
        user => $rails_user,
        group => $rails_group,
        #mkdir $compile_dir
        command => "mkdir $compile_dir",
        unless => "ls $compile_dir",
     }

     exec { "wget_ruby_source_$ruby_version":
        path => ['/bin','/usr/bin','/usr/sbin','/sbin'],
        cwd => $compile_dir,
        user => $rails_user,
        group => $rails_group,
        #Remote github. I created simple script on github gist.
        command => "wget $ruby_url && tar xvzf $ruby_source",
        unless => "ls $compile_dir/$ruby_source",
        require => Exec["mkdir_$compile_dir"],
        timeout => 0,
      }

    exec { "compile_$ruby_version":
        path => ['/bin','/usr/bin','/usr/sbin','/sbin',"$config_dir"],
        cwd => $config_dir,
        user => $rails_user,
        group => $rails_group,
        command => "$config_dir/configure --prefix=$ruby_each_home && make && make install",
        unless => "ls $ruby_path",
        require => Exec["wget_ruby_source_$ruby_version"],
        timeout => 0,
  
    }
           

     exec { 'remove_compile_dir':
        path => ['/bin','/usr/bin','/usr/sbin','/sbin'],
        cwd => $rails_home,
        command => "rm -rf $compile_dir",
        require => Exec["compile_$ruby_version"],
     }


     file { "$rails_home/.bashrc":
        ensure => present,
        owner => $rails_user,
        group => $rails_group,
        mode => 0644,
        content => template("rails4/.bashrc.erb"),
        require => Exec["remove_compile_dir"],
      }

}
