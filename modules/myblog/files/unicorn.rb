root = "/home/rails4/myblog"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_err.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.blog.sock"

worker_processes 2
timeout 30

before_exec do |_|
ENV["BUNDLE_GEMFILE"] = File.join(root,'Gemfile')
end
