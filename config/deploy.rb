set :application, "vinifera"
set :repository,  "git@github.com:cawel/vinifera.git"
set :domain, "209.20.85.218"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
set :scm, :git
set :deploy_via, :remote_cache

set :user, 'mongrel'
set :runner, 'mongrel'
set :use_sudo, false

ssh_options[:paranoid] = false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

task :update_config, :roles => [:app] do
  run "cp -Rf #{shared_path}/config/* #{release_path}/config/"
  run "ln -s #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
end

after "deploy:update_code", :update_config
