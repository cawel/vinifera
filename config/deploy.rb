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


namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end 
end

desc "Re-establish symlinks"
task :after_symlink do
  run <<-CMD
    rm -fr #{release_path}/db/sphinx &&
    ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx
  CMD
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

desc "Stop the sphinx server"
task :stop_sphinx , :roles => :app do
  run "cd #{current_path} && rake thinking_sphinx:stop RAILS_ENV=production"
end

desc "Start the sphinx server"
task :start_sphinx, :roles => :app do
  run "cd #{current_path} && rake thinking_sphinx:configure RAILS_ENV=production && rake thinking_sphinx:start RAILS_ENV=production"
end

desc "Restart the sphinx server"
task :restart_sphinx, :roles => :app do
  stop_sphinx
  start_sphinx
end  
