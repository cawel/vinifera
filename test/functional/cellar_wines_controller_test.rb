require File.dirname(__FILE__) + '/../test_helper'

class CellarWinesControllerTest < ActionController::TestCase

  context "POST /cellar_wines when not logged in" do
    setup do
      post :create, :person_id => 1, :wine_id => 1
    end
    should_set_the_flash_to(/d'abord ouvrir une session/)
    should_redirect_to("the new session url") { login_url }
  end

  logged_in_as :mat do
    context "GET index for a user which does not exist" do
      setup do
        get :index, :person_id => 999
      end
      should_set_the_flash_to(/existe pas/)
      should_redirect_to("the homepage") { root_url }
    end
  end

  logged_in_as :mat do
    context "GET index of his own cellar wines" do
      setup do
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

    context "GET index for somebody else's cellar wines" do
      setup do
        2.times{ Factory(:cellar_wine, :person_id => people(:james).id) }
        get :index, :person_id => people(:james).id
      end

      should "not have a 'delete' icon for each wine " do
        assert_select "td.actions", 0
      end

      should "assign cellar_wines" do
        assert assigns(:cellar_wines)
      end
    end
  end

end
