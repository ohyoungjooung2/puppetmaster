class java::oracle_jdk7{
     $user="rails4"
     $group="rails4"
     $rails_home="/home/rails4"
     $java_install_path="$rails_home/java/bin"
     $jdk_version="jdk1.7.0_79"
     $jdk_file="jdk-$jdk_version-linux-x64.tar.gz"
     $java_dir="$rails_home/.java_$jdk_version"
     $oracle_java7_url="http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz"
     $cookie="--no-cookies"
     $cert_verify="--no-check-certificate"
     $header="--header"
     $header_value="Cookie: oraclelicense=accept-securebackup-cookie"
     
     # do something ubuntu specific
     # execute 'apt-get update'
     exec { 'apt-update':
       user => 'root',
       group => 'root',
       command => '/usr/bin/apt-get update',
       #before  => Stage["main"],
     }
     exec { 'wget-install':
       path => ['/bin','/usr/sbin','/usr/local/bin','/usr/local/sbin','/sbin','/usr/bin'],
       command => 'apt-get install wget',
       unless => 'ls /usr/bin/wget',
       require => Exec['apt-update'],
     }

     exec { 'jdk7-get-untar':
       path => ['/bin','/usr/sbin','/usr/local/bin','/usr/local/sbin','/sbin','/usr/bin'],
       cwd => $rails_home,
       user => $user,
       group => $group,
       #when using oracle web site
       command => "wget $cookie $cert_verify $header \"$header_value\" \"$oracle_java7_url\" -O $jdk_file ",
       #when using local web
       #command => "wget $local_web/$jdk_file",
       unless => "ls $rails_home/$jdk_file",
       timeout => 0,
       #require => Exec['wget-install'],
      }

     exec { 'jdk7-install-to-path':
       path => ['/bin','/usr/sbin','/usr/local/bin','/usr/local/sbin','/sbin','/usr/bin'],
       user => $user,
       group => $group,
       cwd => $rails_home,
       command => "tar xvzf $jdk_file && mv $jdk_version $java_dir && rm -rf $jdk_version $jdk_file",
       unless => "ls $java_install_path",
       require => Exec['jdk7-get-untar'],
     }

      
}
#Wget oracle java7 rpm
#root@puppetclient1:~# wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.rpm" -O jdk-7-linux-x64.rpm
#Wget oracle java8 rpm
#root@puppetclient1:~# wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm" -O jdk-8-linux-x64.rpm
#Wget oracle java7 tar.gz
#root@puppetclient1:~# wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz" -O jdk-7-linux-x64.tar.gz
#Wget oracle java8 tar.gz
#root@puppetclient1:~# wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz" -O jdk-8-linux-tar.gz
