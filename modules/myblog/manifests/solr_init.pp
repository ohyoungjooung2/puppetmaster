class myblog::solr_init inherits myblog::config {
     #Solr search init 
     exec { "start_solr":
          path => ["$ruby_path","$blog_config","/usr/bin","/bin","/sbin","/usr/sbin","/usr/local/bin"],
          cwd  => "$blog_config",
          user => "$user",
          group => "$group",
          command => "$ruby_path/rake sunspot:solr:start RAILS_ENV=\"production\"",
          require => Exec["start_unicorn"],
     }
}
