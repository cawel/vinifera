require File.dirname(__FILE__) + '/../test_helper'

class ReviewsControllerTest < ActionController::TestCase

  logged_in_as :mat do
    context "GET /edit somebody else's review" do
      setup do
        @mat = people(:mat)
        @martin = people(:martin)
        get :edit, :wine_id => @martin.reviews.first.wine.id, :id => @martin.reviews.first.id
      end

      should_set_the_flash_to(/pas modifier les critiques/)
      should_redirect_to("the user's reviews index") { person_reviews_index_url(@mat)  }
    end

    context "PUT update somebody else's review" do
      setup do
        @mat = people(:mat)
        @martin = people(:martin)
        put :update, :wine_id => @martin.reviews.first.wine.id, :id => @martin.reviews.first.id
      end

      should_set_the_flash_to(/pas modifier les critiques/)
      should_redirect_to("the user's reviews index") { person_reviews_index_url(@mat)  }
    end

    context "DELETE destroy somebody else's review" do
      setup do
        @mat = people(:mat)
        @martin = people(:martin)
        delete :destroy, :wine_id => @martin.reviews.first.wine.id, :id => @martin.reviews.first.id
      end

      should_set_the_flash_to(/pas modifier les critiques/)
      should_redirect_to("the user's reviews index") { person_reviews_index_url(@mat)  }
    end
  end

end
