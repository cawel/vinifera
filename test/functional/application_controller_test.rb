require File.dirname(__FILE__) + '/../test_helper'

class ApplicationControllerTest < ActionController::TestCase
  def setup
    @controller           = ApplicationController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
  end
  

end
