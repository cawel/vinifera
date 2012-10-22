set :application, "vinifera"
set :repository,  "git@github.com:cawel/vinifera.git"
set :domain, "67.212.16.78"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :deploy_via, :remote_cache

set :user, 'cawel'
set :runner, 'cawel'
set :use_sudo, false
set :branch, 'asylum'

set :keep_releases, 5 

ssh_options[:paranoid] = false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

before "deploy", "validate_remote_branch_freshness"
after "deploy:update",  :tag_deployed_commit

task :validate_remote_branch_freshness do
  unless 'true' == ENV['DEPLOY_OLD_BRANCH']
    refs          = run_locally "git show-ref #{branch}"
    local_ref     = refs.scan(/(\w+)\s+refs\/heads\//).to_s
    deployed_ref  = refs.scan(/(\w+)\s+refs\/remotes\/origin\//).to_s
    if local_ref != deployed_ref
      abort "\nYour local #{branch} branch is not up to date with origin/#{branch}.\n" +
      "  (local: #{local_ref} remote: #{deployed_ref})\n" +
      "Push your changes or force the deployment of the outdated branch with 'cap deploy DEPLOY_OLD_BRANCH=true'"
    end 
  end 
end

task :tag_deployed_commit do
  tag = "prod-#{ Time.now.strftime('%Y-%b-%d--%Hh%M') }"
  run_locally "git tag -m 'deploy by #{ENV['USER']}' -a #{tag} remotes/origin/#{branch} && git push --tags"
end


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
  run "ln -nfs #{shared_path}/config/site_keys.rb #{release_path}/config/initializers/site_keys.rb"
  run "ln -nfs #{shared_path}/config/emails.rb #{release_path}/config/initializers/emails.rb"
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


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
