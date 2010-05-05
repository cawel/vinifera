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

    should "assign cellar_count" do
      assert assigns( :cellar_count)
    end

    should "assign review_count" do
      assert assigns( :review_count)
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

  context "GET /" do
    setup do
      get :index
    end

    should "not show any action buttons in sidebar" do
      assert_select "#sidebar .actions", 0
    end
  end

  logged_in_as :mat do
    context "GET /" do
      setup do
        get :index
      end

      should "show 'journal des critiques' button" do
        assert_select "#sidebar .actions .reviews"
      end

      should "show 'mon cellier' button" do
        assert_select "#sidebar .actions .cellar"
      end
    end
  end
end
