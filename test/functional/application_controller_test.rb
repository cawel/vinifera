require File.dirname(__FILE__) + '/../test_helper'

class ApplicationControllerTest < ActionController::TestCase
  def setup
    @controller           = ApplicationController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
  end
  
  should_route :get, "/", :controller => :application, :action => :home

  context "the home page" do
    setup do
      get :home
    end
    should "assign timeline_events" do
      assert assigns( :timeline_events)
    end
  end

end
