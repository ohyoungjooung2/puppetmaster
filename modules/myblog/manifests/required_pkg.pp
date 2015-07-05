class myblog::required_pkg {
     $required_package = ["git","nodejs","libmysqlclient-dev"]
     package { $required_package: ensure => "installed"}
}
