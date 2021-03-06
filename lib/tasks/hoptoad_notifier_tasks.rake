Dir[File.join(RAILS_ROOT, 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

begin
  require 'hoptoad_notifier/tasks'
rescue LoadError
end
