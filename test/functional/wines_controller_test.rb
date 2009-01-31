require 'test_helper'

class WinesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:wines)
  end
  
  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_wine
    assert_difference('Wine.count') do
      post :create, :wine => {:name => 'name', :color_id => colors(:red) }
    end
    
    assert_redirected_to wines_path
  end
  
  #  def test_should_show_wine
  #    get :show, :id => wines(:one).id
  #    assert_response :success
  #  end
  
  def test_should_get_edit
    get :edit, :id => wines(:chateau_coulac).id
    assert_response :success
  end
  
  def test_should_update_wine
    put :update, :id => wines(:chateau_coulac).id, :wine => { }
    assert_redirected_to wine_path(assigns(:wine))
  end
  
  def test_should_destroy_wine
    assert_difference('Wine.count', -1) do
      delete :destroy, :id => wines(:chateau_coulac).id
    end
    
    assert_redirected_to wines_path
  end
end
