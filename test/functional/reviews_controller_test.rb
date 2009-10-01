require File.dirname(__FILE__) + '/../test_helper'

class ReviewsControllerTest < ActionController::TestCase

  logged_in_as :mat do
    context "PUT /create a new review" do
      setup do
        post :create, :wine_id => wines(:chateau_coulac).id, :review => {:rating_id => "1", :comment => "my review"}
      end

      should_set_the_flash_to(/critique a été ajoutée/)
      should_redirect_to("the reviews index") { wine_reviews_url(wines(:chateau_coulac)) }
    end

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

  logged_in_as :admin do
    context "GET /edit somebody else's review" do
      setup do
        @james = people(:james)
        get :edit, :wine_id => @james.reviews.first.wine.id, :id => @james.reviews.first.id
      end

      should_not_set_the_flash
      should_render_template :edit
    end

    context "PUT update somebody else's review" do
      setup do
        @james = people(:james)
        put :update, :wine_id => @james.reviews.first.wine.id, :id => @james.reviews.first.id
      end

      should_set_the_flash_to(/critique a été mise à jour/)
      should_redirect_to("the wine's reviews") { wine_reviews_url(@james.reviews.first.wine) }
    end

    context "DELETE destroy somebody else's review" do
      setup do
        @james = people(:james)
        @wine_id = @james.reviews.first.wine.id
        delete :destroy, :wine_id => @wine_id, :id => @james.reviews.first.id
      end

      should_set_the_flash_to(/Votre critique a été retirée/)
      should_redirect_to("the wine's reviews") { wine_reviews_url(@wine_id) }
    end
  end

end
