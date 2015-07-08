class rails4::jruby inherits rails4::config {
     $jruby_version="jruby-9.0.0.0.rc1"
     $jruby_source="jruby-bin-9.0.0.0.rc1.$ext"
     $jruby_dir="$rails_home/.jrubies"
     $jruby_each_home="$jruby_dir/$jruby_version"
     $jruby_path="$jruby_each_home/bin"


     #jruby url
     $jruby_url="https://s3.amazonaws.com/jruby.org/downloads/9.0.0.0.rc1/jruby-bin-9.0.0.0.rc1.tar.gz"

     #Create $jruby_dir
     file { "$jruby_dir":
            ensure => "directory",
            owner => "$rails_user",
            group => "$rails_group",
            mode => 0755,
      }



     exec { "wget_jruby_source_$jruby_version":
        path => ['/bin','/usr/bin','/usr/sbin','/sbin'],
        cwd => $rails_home,
        user => $rails_user,
        group => $rails_group,
        command => "wget $jruby_url && tar xvzf $jruby_source",
        unless => "ls -f $jruby_source",
        require => File["$jruby_dir"],
        timeout => 0,
      }


    exec { "mv_jruby_version_to_$jruby_dir":
           cwd => $rails_home,
           user => $rails_user,
           group => $rails_group,
           command => "mv $jruby_version $jruby_dir/",
           unless => "ls -f $jruby_each_home",
           require => Exec["wget_jruby_source_$jruby_version"],
         }
 

            
    exec { "remove_$jruby_source":
           cwd => $rails_home,
           user => $rails_user,
           group => $rails_group,
           command => "rm -f $rails_home/$jruby_source",
           onlyif => "ls -f $rails_home/$jruby_source",
           require => Exec["wget_jruby_source_$jruby_version"],
    }
 


     file { "$rails_home/.bashrc":
        ensure => present,
        owner => $rails_user,
        group => $rails_group,
        mode => 0644,
        content => template("rails4/.jruby.bashrc.erb"),
        require => Exec["remove_$jruby_source"],
      }


}
