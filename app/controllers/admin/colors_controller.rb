class Admin::ColorsController < Admin::ApplicationController
  layout 'application'
  
  active_scaffold :color do |config|
    config.columns = [:name]
    list.sorting = {:name => 'ASC'}
  end
  
end
