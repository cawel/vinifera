require File.dirname(__FILE__) + '/../test_helper'

class ContentsControllerTest < ActionController::TestCase

  should_route :get, "/contact", :controller => :contents, :action => :contact
  should_route :get, "/a-propos", :controller => :contents, :action => :about

end
