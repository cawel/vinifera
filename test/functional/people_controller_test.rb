require File.dirname(__FILE__) + '/../test_helper'
require 'people_controller'

# Re-raise errors caught by the controller.
class PeopleController; def rescue_action(e) raise e end; end

class PeopleControllerTest < Test::Unit::TestCase
  def setup
    @controller = PeopleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @person     = people :james
  end
  
  should_be_restful do |resource|
    resource.formats         = [:html]
    resource.actions         = [:new, :create, :show]
    resource.create.params   = hash_for_person
    resource.create.redirect = 'root_url'
    resource.create.flash    = /Ouverture du compte complétée/i
  end
  
  logged_in_as :james do
    should_be_restful do |resource|
      resource.formats         = [:html]
      resource.actions         = [:edit, :update]
      resource.update.flash    = /à jour/i
    end
    
    context "on GET :edit another person" do
      setup do
        get :edit, :id => (@person.id - 1)
      end
      should_set_the_flash_to /son propre compte/i
      should_redirect_to 'edit_person_url(@person)'
    end
    
    context "on PUT :update another person" do
      setup do
        get :edit, :id => (@person.id - 1)
      end
      should_set_the_flash_to /son propre compte/i
      should_redirect_to 'edit_person_url(@person)'
    end
    
  end
  
end