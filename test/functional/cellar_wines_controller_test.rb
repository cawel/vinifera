require File.dirname(__FILE__) + '/../test_helper'

class CellarWinesControllerTest < ActionController::TestCase

  logged_in_as :mat do
    context "GET index of cellar wines" do
      setup do
        ApplicationController.stubs(:current_person).returns(people(:mat))
        2.times{ Factory(:cellar_wine, :person_id => people(:mat).id) }
        get :index, :person_id => people(:mat).id
      end

      should "have a 'delete' icon for each wine " do
        assert_select "td.actions", 2
      end

      should "assign cellar_wines" do
        assert assigns(:cellar_wines)
      end
    end
  end

end
