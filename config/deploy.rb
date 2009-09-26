set :application, "vinifera"
set :repository,  "git@github.com:cawel/vinifera.git"
set :domain, "209.20.85.218"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :deploy_via, :remote_cache

set :user, 'cawel'
set :runner, 'cawel'
set :use_sudo, false

set :keep_releases, 5 

ssh_options[:paranoid] = false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

task :update_config, :roles => [:app] do
  run "cp -Rf #{shared_path}/config/* #{release_path}/config/"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end 
end

after "deploy:update_code", :update_config
