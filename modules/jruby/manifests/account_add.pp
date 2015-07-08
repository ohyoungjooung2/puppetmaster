class rails4::account_add {
        user { 'rails4':
            ensure => present,
            #to remove
            #ensure => absent,
            comment => 'rails4 user',
            home => '/home/rails4',
            managehome => 'true',
            shell => '/bin/bash',
            uid => 3000,
            gid => 3000,
       }

       group {"rails4":
            gid => 3000,
       }

       ssh_authorized_key { 'rails4_ssh':
            user => 'rails4',
            type => 'rsa',
            key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCggNfNNu4/OgS6h9Mw6HFEImZhr6sMcUTVTpkZ+7ijbr4LKqm4uopylg45wNfDG+sOAp90Sh2BdMDG316nl8wn/RhN5BR5+FVagJI4oG9iPNfkEfxYBtkYwH6ld+GCWUJrsnqV/krIH+umVBLxmnKnfDrV82gvmPnSh6AXgPS6mrdWv3d7+VOS2fkQMXSd0I4NRoWZ5s3EhISTAJsAlKWrW7zMqZgyN4+PPYyDk6qfvVulH2kPGGjjP8FKVDosFZK6z0Hj/79PAGgXrHBRl7RhC/Kv2MGSYatC3g0mVHMHQDjoZ446ixhf/JTqnl0ODIn8R+53m8xGJqk+ZdMOsfkx',
       }
}
