class rails4::config {

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
     $jdk_version="jdk1.7.0_79"
     $java_path="$rails_home/.java_$jdk_version/bin"

}
