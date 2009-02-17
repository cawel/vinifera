require File.dirname(__FILE__) + '/../test_helper'

require 'wines_controller'

# Re-raise errors caught by the controller.
class WinesController; def rescue_action(e) raise e end; end

class WinesControllerTest < ActionController::TestCase
  def setup
    @controller           = WinesController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @wine                 = wines :chateau_coulac
    @person               = people(:james)
  end
  
  should_be_restful do |resource|
    resource.formats         = [:html]
    resource.actions         = [:index, :show]
  end
  
  logged_in_as :james do
    should_be_restful do |resource|
      resource.formats         = [:html]
      resource.actions         = [:new, :create, :edit, :update, :destroy]
      resource.create.params   = { :color_id => 1, :name =>'my new wine'}
      resource.create.redirect = 'wines_url'
      resource.create.flash    = /ajouté/i
      
      resource.update.redirect = 'wines_url'
      resource.update.flash    = /à jour/i
      
      resource.destroy.flash   = /retiré/i
    end
    
    context "on POST :create" do
      setup do
        post :create, :wine => { :color_id => 1, :name =>'my new wine'}
      end
      
      should "assign person to newly created wine" do
        wine = Wine.find_by_name('my new wine')
        assert_equal wine.person, @person
      end
    end
    
  end
  
  not_logged_in do
    context "on GET :new" do
      setup do
        get :new
      end
      should_redirect_to 'login_url'
    end
    
    context "on POST :create" do
      setup do
        post :create, :wine => {}
      end
      should_redirect_to 'login_url'
    end
    
    context "on GET :edit" do
      setup do
        get :edit, :id => wines(:chateau_coulac).id
      end
      should_redirect_to 'login_url'
    end
    
    context "on POST :update" do
      setup do
        put :update, :id => wines(:chateau_coulac).id, :wine => {}
      end
      should_redirect_to 'login_url'
    end
    
    context "on DELETE :destroy" do
      setup do
        delete :destroy, :id => wines(:chateau_coulac).id
      end
      should_redirect_to 'login_url'
    end
    
  end
end
