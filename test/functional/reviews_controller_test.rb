require File.dirname(__FILE__) + '/../test_helper'

class ReviewsControllerTest < ActionController::TestCase

  context "POST /reviews when not logged in" do
    setup do
      post :create, :wine_id => 1, :person_id => 1
    end
    should_set_the_flash_to(/d'abord ouvrir une session/)
    should_redirect_to("the new session url") { login_url }
  end

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

  logged_in_as :mat do
    context "GET user_reviews_index for a user which does not exist" do
      setup do
        get :user_reviews_index, :person_id => 999
      end
      should_set_the_flash_to(/existe pas/)
      should_redirect_to("the homepage") { root_url }
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
        @wine = @james.reviews.first.wine
        delete :destroy, :wine_id => @wine.id, :id => @james.reviews.first.id
      end

      should_set_the_flash_to(/Votre critique a été retirée/)
      should_redirect_to("the wine's reviews") { wine_reviews_url(@wine) }
    end
  end

  def review_button_selector
    ".wine_actions .action .reviews"
  end

  def cellar_button_selector
    ".wine_actions .action .cellar"
  end

  context "GET /" do
    setup do
      get :index, :wine_id => Factory(:wine).id
    end

    should "not show any action buttons in sidebar" do
      assert_select review_button_selector, 1
      assert_select cellar_button_selector, 0
    end
  end

  logged_in_as :mat do
    context "GET /" do
      setup do
        get :index, :wine_id => Factory(:wine).id
      end

      should "show 'journal des critiques' button" do
        assert_select review_button_selector
      end

      should "show 'mon cellier' button" do
        assert_select cellar_button_selector
      end
    end
  end

end
