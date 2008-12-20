require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_review
    assert_difference('Review.count') do
      post :create, :review => { }
    end

    assert_redirected_to review_path(assigns(:review))
  end

  def test_should_show_review
    get :show, :id => reviews(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => reviews(:one).id
    assert_response :success
  end

  def test_should_update_review
    put :update, :id => reviews(:one).id, :review => { }
    assert_redirected_to review_path(assigns(:review))
  end

  def test_should_destroy_review
    assert_difference('Review.count', -1) do
      delete :destroy, :id => reviews(:one).id
    end

    assert_redirected_to reviews_path
  end
end
