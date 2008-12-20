require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:ratings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_rating
    assert_difference('Rating.count') do
      post :create, :rating => { }
    end

    assert_redirected_to rating_path(assigns(:rating))
  end

  def test_should_show_rating
    get :show, :id => ratings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => ratings(:one).id
    assert_response :success
  end

  def test_should_update_rating
    put :update, :id => ratings(:one).id, :rating => { }
    assert_redirected_to rating_path(assigns(:rating))
  end

  def test_should_destroy_rating
    assert_difference('Rating.count', -1) do
      delete :destroy, :id => ratings(:one).id
    end

    assert_redirected_to ratings_path
  end
end
