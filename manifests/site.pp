Exec { path => ['/bin','/usr/sbin','/usr/local/bin','/usr/local/sbin','/sbin','/usr/bin'], }
node default {}
node 'puppetclient1'{
     #rails4 account add
     include rails4::account_add
     #Require packages for compiling ruby2.x? from source
     include rails4::ruby22_pre
     #compile ruby $version
     include rails4::ruby_compile
     include mysql::server
     include java::oracle_jdk7
}

node 'centos7-puppet-client'{
     #rails4 account add
     include rails4::account_add
     #Require packages for compiling ruby2.x? from source
     include rails4::ruby22_pre
     #compile ruby $version
     include rails4::ruby_compile
}
node 'puppetclient2'{
     #rails4 account add
     include rails4::account_add
     #Require packages for compiling ruby2.x? from source
     include rails4::ruby22_pre
     #compile ruby $version
     include rails4::ruby_compile
}
