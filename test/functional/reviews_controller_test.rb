require File.dirname(__FILE__) + '/../test_helper'

class ReviewsControllerTest < ActionController::TestCase

  logged_in_as :mat do
    context "GET /edit somebody else's review" do
      setup do
        @mat = people(:mat)
        @james = people(:james)
        get :edit, :wine_id => @james.reviews.first.wine.id, :id => @james.reviews.first.id
      end

      should_set_the_flash_to(/pas modifier les critiques/)
      should_redirect_to("the user's reviews index") { person_reviews_index_url(@mat)  }
    end

    context "PUT update somebody else's review" do
      setup do
        @mat = people(:mat)
        @james = people(:james)
        put :update, :wine_id => @james.reviews.first.wine.id, :id => @james.reviews.first.id
      end

      should_set_the_flash_to(/pas modifier les critiques/)
      should_redirect_to("the user's reviews index") { person_reviews_index_url(@mat)  }
    end

    context "DELETE destroy somebody else's review" do
      setup do
        @mat = people(:mat)
        @james = people(:james)
        delete :destroy, :wine_id => @james.reviews.first.wine.id, :id => @james.reviews.first.id
      end

      should_set_the_flash_to(/pas modifier les critiques/)
      should_redirect_to("the user's reviews index") { person_reviews_index_url(@mat)  }
    end
  end

end
