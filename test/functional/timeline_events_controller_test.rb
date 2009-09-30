require File.dirname(__FILE__) + '/../test_helper'

class TimelineEventsControllerTest < ActionController::TestCase

  should_route :get, '/', :controller => :timeline_events, :action => :index

  context "GET on / format html" do 
    setup do
      get :index
    end

    should_respond_with :success
    should_render_template :index

    should "assign timeline_events" do
      assert assigns( :timeline_events)
    end
  end


  should_route :get, '/dernieres_critiques.rss', :controller => :timeline_events, :action => :index, :format => :rss

  context "GET on / format rss" do 
    setup do
      get :index, :format => 'rss'
    end

    should_respond_with :success
    should_render_template :index

    should "assign timeline_events" do
      assert assigns( :timeline_events)
    end
  end

end
