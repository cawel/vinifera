# tell the I18n library where to find your translations

#add overrides for resource_controller
I18n.load_path += Dir[ File.join(RAILS_ROOT, 'config', 'locales', 'resource_controller', '*.yml') ]

#add overrides for rails
I18n.load_path += Dir[ File.join(RAILS_ROOT, 'config', 'locales', 'rails', '*.yml') ]


I18n.default_locale = "fr-CA"