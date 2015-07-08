class rails4::ruby22_pre {

    #To compile ruby2.2. There are packages to compile ruby2.2
    case $::operatingsystem {
      'Ubuntu','Debian': {
                          $for_ruby_22 = [ "git-core", "curl", "zlib1g-dev", "build-essential", "libssl-dev", "libreadline-dev", "libyaml-dev", "libsqlite3-dev", "sqlite3", "libxml2-dev", "libxslt1-dev", "libcurl4-openssl-dev", "python-software-properties", "libffi-dev"]
                        package { $for_ruby_22: ensure => "installed" }    

  
                        }

     'Centos','Redhat','Scientific','OracleLinux','OEL': {
                          $for_ruby_22 = [ "git", "zlib", "zlib-devel", "gcc-c++", "patch", "readline", "readline-devel", "libyaml-devel", "libffi-devel", "openssl-devel", "make", "bzip2", "autoconf", "automake", "libtool", "bison", "curl", "sqlite-devel"]
 
                          package { $for_ruby_22: ensure => "installed" }

                                            	       }

   }  

}

