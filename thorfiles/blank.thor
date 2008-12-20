# module: blank

class Blank < Thor
  BLANK_REPO = 'git://github.com/giraffesoft/blank.git'
  
  desc "new_app NAME [REPO] [BRANCH]", "Create a new blank app, from branch BRANCH (defaults to master), in directory NAME, push it to REPO."
  def new_app(name, repo=nil, branch=nil)
    @name = name
    @repo = repo
    
    puts "---- Cloning blank from #{BLANK_REPO}..."
    `git clone -o blank #{BLANK_REPO} #{name}`
    `cd #{name}; git checkout blank/#{branch}` unless branch.nil? || branch == ''
    rake 'blank:switch_to_app_gitignore'
    commit "Switch to gitignore that doesnt ignore site_keys.rb." if repo?
    
    
    puts "\n---- Generating site keys for restful-auth..."
    rake 'auth:gen:site_key'
    commit "Add generated site_keys.rb file." if repo?
    
    if repo?
      puts "\n---- Pushing to repo @ #{repo}..."
      rake 'blank:switch_origin', :repo => repo
    end
    
    puts "\n---- Generating a session configuration."
    rake "blank:session_config", :name => name
    commit "Add generated session configuration." if repo?
    
    puts "\n---- Loading db schema, and creating dbs."
    rake "db:schema:load"
    rake "db:test:prepare"
    
    puts "\n---- There are TODOs in blank. Here's the output of rake notes, for your perusal:"
    puts rake(:notes)
  end
  
  protected
    def in_project_dir(cmd)
      `cd #{@name}; #{cmd}`
    end
  
    def rake(task, opts={})
      args = opts.map { |name, value| name.to_s.upcase + "=" + value }.join(' ')
      in_project_dir "rake #{task} #{args}"
    end
    
    def commit(msg)
      in_project_dir "git add ."
      in_project_dir "git commit -m\"#{msg} (This commit was generated by blank\'s new_app thor task.)\""
    end

    def repo?
      !@repo.nil? && !@repo == ''
    end
end
