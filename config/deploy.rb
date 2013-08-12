require 'rvm/capistrano'

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, 'read-only'

before 'deploy:setup', 'rvm:install_rvm'  # install RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR:

set :application, "on-my-way"
set :repository,  "git@github.com:drunkhacker/onmyway.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "175.41.249.100"                          # Your HTTP server, Apache/etc
#role :app, "175.41.249.100"                          # This may be the same as your `Web` server
server  "175.41.249.100", :app, :web, :db, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

set :ssh_options, {:forward_agent => true, :keys => "~/.ssh/onmyway.pem"}
set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/onmyway"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
