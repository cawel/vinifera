desc 'Generate documentation for the ResourceController plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActivePresenter'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :upload_docs => :rdoc do
  puts 'Deleting previous rdoc'
  `ssh jamesgolick.com 'rm -Rf /home/apps/jamesgolick.com/public/active_presenter/rdoc'`
  
  puts "Uploading current rdoc"
  `scp -r rdoc jamesgolick.com:/home/apps/jamesgolick.com/public/active_presenter/rdoc`
  
  puts "Deleting rdoc"
  `rm -Rf rdoc`
end
