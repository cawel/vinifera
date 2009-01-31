require 'test_helper'

class Admin::VarietiesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:varieties)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_variety
    assert_difference('Variety.count') do
      post :create, :variety => { }
    end

    assert_redirected_to variety_path(assigns(:variety))
  end

  def test_should_show_variety
    get :show, :id => varieties(:variety_1).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => varieties(:variety_1).id
    assert_response :success
  end

  def test_should_update_variety
    put :update, :id => varieties(:variety_1).id, :variety => { }
    assert_redirected_to variety_path(assigns(:variety))
  end

  def test_should_destroy_variety
    assert_difference('Variety.count', -1) do
      delete :destroy, :id => varieties(:variety_1).id
    end

    assert_redirected_to varieties_path
  end
end
