# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Blank's default dependencies
  config.gem "ruby-openid", :lib => "openid"
  config.gem "active_presenter"
  config.gem "andand"
  #config.gem 'resource_controller'

  config.gem "mislav-will_paginate",            :lib => "will_paginate",   :source => "http://gems.github.com"
  config.gem "giraffesoft-attribute_fu",        :lib => "attribute_fu",    :source => "http://gems.github.com"

  # Application-specific dependencies
  config.gem "freelancing-god-thinking-sphinx", :lib => "thinking_sphinx", :source => "http://gems.github.com", :version => "1.2.11"
  config.gem 'hoptoad_notifier'
  config.gem 'simple-rss'


  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  config.autoload_paths += %W( #{RAILS_ROOT}/app/presenters #{RAILS_ROOT}/app/mailers )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'UTC'

  session_config = RAILS_ROOT+'/config/session.rb'
  File.exist?(session_config) ? load(session_config) : raise("You are missing your config/session.rb file. Please run rake blank:session_config.")  
  config.action_controller.session = SESSION_CONFIG
  config.action_controller.resources_path_names = { :new => 'creation', :edit => 'mise-a-jour' } 

  # Better handling of erroneous fields
  #ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "<span class=\"fieldWithErrors\">#{html_tag}</span>" }

  config.action_controller.page_cache_directory = RAILS_ROOT + '/tmp/cache'

end
