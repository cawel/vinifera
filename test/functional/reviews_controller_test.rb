#require File.dirname(__FILE__) + '/../test_helper'
require 'test_helper'

require 'reviews_controller'

# Re-raise errors caught by the controller.
class ReviewsController; def rescue_action(e) raise e end; end

class ReviewsControllerTest < ActionController::TestCase
  def setup
    @controller           = ReviewsController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @review               = reviews :good_wine
    @person = people(:james)
  end
  
  should_be_restful do |resource|
    resource.parent = :wine
    resource.formats = [:html]
    resource.actions         = [:index, :show]
  end
  
  
  logged_in_as :james do
    
    should_be_restful do |resource|
      resource.parent          = :wine
      resource.formats         = [:html]
      resource.actions         = [:new, :create, :edit, :update, :destroy]
      resource.create.params = { :rating_id => 1}
      resource.create.redirect = 'wine_reviews_url'
    end
  end
  
  not_logged_in do
    context "on GET :new" do
      setup do
        get :new, :wine_id => reviews(:good_wine).wine.id
      end
      should_redirect_to 'login_url'
    end
    
    context "on POST :create" do
      setup do
        post :create, :wine_id => reviews(:good_wine).wine.id
      end
      should_redirect_to 'login_url'
    end
    
    context "on GET :edit" do
      setup do
        get :edit, :wine_id => reviews(:good_wine).wine.id, :id => reviews(:good_wine).id
      end
      should_redirect_to 'login_url'
    end
    
    context "on POST :update" do
      setup do
        post :update, :wine_id => reviews(:good_wine).wine.id, :id => reviews(:good_wine).id
      end
      should_redirect_to 'login_url'
    end
    
  end
  
end
