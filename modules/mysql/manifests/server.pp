class mysql::server{
       
       $version="5.6"
#       $port = "3306"
#       $socket = "/var/run/mysqld/mysqld.sock"
#       $nice = "0"
#       $skip_name_resolve="1"
#       $user = "mysql"
#       $pid = "/var/run/mysqld/mysqld.pid"
#       $basedir = "/usr"
#       $datadir = "/var/lib/mysql"
#       $tmpdir = "/tmp"
#       $bind_address = "127.0.0.1"
#       $lcm_dir = "/usr/share/mysql"
#       $key_buffer = "16"
#       $max_allowed_packet = "7M"
#       $thread_stack            = "256K"
#       $thread_cache_size       = "128M"
#       $thread_con = "64"
#       $max_con = "100"
#       $myisam_recover         = "BACKUP"
#
#       $query_cache_type        =  "1"
#       $query_cache_limit       = "1M"
#       $query_cache_size        = "100M"
#
#       $log_error = "/var/log/mysql/error.log"
#
#       $innodb_buffer_pool_size = "128M"
#       #innodb_thread_concurrency = "256"
#       $innodb_buffer_pool_instances = "1"
#       $innodb_flush_method  = "O_DSYNC"
#       $innodb_checksums = "OFF"
#       $innodb_doublewrite = "OFF"
#       $innodb_read_io_threads = "16"
#       $innodb_write_io_threads = "8"
#
#       $max_allowed_packet      = "16M"
#       $key_buffer              = "16M"
#       $inc_dir = "/etc/mysql/conf.d/"
         $path = ['/bin','/sbin','/usr/bin','/sbin','/usr/sbin']


       package { "mysql-server-$version":
                  ensure => installed,
                  before => File["/etc/mysql/my.cnf"]
       }


       file {
                  "/etc/mysql/my.cnf":
                  owner => root,
                  group => root,
                  mode => 644,
                  source => "puppet:///modules/mysql/my.cnf"
                  #content => template("mysql/my.cnf.erb"),

            }

       service {
                  "mysql":
                   ensure => running,
                   subscribe => File["/etc/mysql/my.cnf"]
               }

       exec { "mysql_password":
                   path => $path,
                   command => "mysqladmin -uroot password root",
                   unless => "mysqladmin -uroot -proot status",
                   require => Service[mysql];
           }

       exec { "myblog_db":
                   path => $path,
                   command => "mysql -uroot -proot -e 'create database myblog_production'",
                   unless => "mysql -uroot -proot myblog_production",
                   require => Exec["mysql_password"]
             }

       exec { "remove_no_password":
                   path => $path,
                   command => "mysql -u root -proot mysql -e 'delete from user where password=\"\" '",
                   require => Exec["myblog_db"],
            }

       exec { "myblog_db_user":
                  path => $path,
                  command => "mysql -u root -proot -e 'GRANT ALL PRIVILEGES ON myblog_production.* to myblog@localhost IDENTIFIED BY \"myblogpass\" '",
                  require => Exec["remove_no_password"]
            }

}
