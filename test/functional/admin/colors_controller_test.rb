require 'test_helper'

class Admin::ColorsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:colors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_color
    assert_difference('Color.count') do
      post :create, :color => { }
    end

    assert_redirected_to color_path(assigns(:color))
  end

  def test_should_show_color
    get :show, :id => colors(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => colors(:one).id
    assert_response :success
  end

  def test_should_update_color
    put :update, :id => colors(:one).id, :color => { }
    assert_redirected_to color_path(assigns(:color))
  end

  def test_should_destroy_color
    assert_difference('Color.count', -1) do
      delete :destroy, :id => colors(:one).id
    end

    assert_redirected_to colors_path
  end
end
