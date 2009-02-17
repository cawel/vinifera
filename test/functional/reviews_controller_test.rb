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
    @review               = reviews :wine1_according_to_james
    @person = people(:james)
  end
  
  should_be_restful do |resource|
    resource.parent   = :wine
    resource.formats  = [:html]
    resource.actions  = [:index, :show]
  end
  
  
  logged_in_as :mat do
    should_be_restful do |resource|
      resource.parent          = :wine
      resource.formats         = [:html]
      resource.actions         = [:new, :create, :edit, :update, :destroy]
      resource.create.params   = {:rating_id => 1, :comment => 'my comment'}

      resource.create.flash    = /critique a été ajoutée/i
      resource.create.redirect = 'wine_reviews_url'
      resource.update.flash    = /à jour/i
      resource.update.redirect = 'wine_reviews_url'
      resource.destroy.flash   = /retiré/i
    end
  end
  
  logged_in_as :martin do
    context "GET :new for a wine the user has already reviewed" do
    setup do
      get :new, :wine_id => reviews(:wine2_according_to_martin).wine.id
    end
    should_set_the_flash_to /Vous avez déjà fait une critique pour ce vin./i
    should_redirect_to 'edit_wine_review_url(@review.wine, @review)'
  end
end

not_logged_in do
  context "on GET :new" do
    setup do
      get :new, :wine_id => wines(:chateau_coulac).id
    end
    should_redirect_to 'login_url'
  end
  
  context "on POST :create" do
    setup do
      post :create, :wine_id => wines(:chateau_coulac).id
    end
    should_redirect_to 'login_url'
  end
  
  context "on GET :edit" do
    setup do
      get :edit, :wine_id => reviews(:wine1_according_to_james).wine.id, :id => reviews(:wine1_according_to_james).id
    end
    should_redirect_to 'login_url'
  end
  
  context "on POST :update" do
    setup do
      put :update, :wine_id => reviews(:wine1_according_to_james).wine.id, :id => reviews(:wine1_according_to_james).id
    end
    should_redirect_to 'login_url'
  end
  
  context "on DELETE :destroy" do
    setup do
      delete :destroy, :wine_id => reviews(:wine1_according_to_james).wine.id, :id => reviews(:wine1_according_to_james).id
    end
    should_redirect_to 'login_url'
  end
  
end

end
