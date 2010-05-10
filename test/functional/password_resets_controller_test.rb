require File.dirname(__FILE__) + '/../test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  context "on GET to :new" do
    setup do
      get :new
    end

    should_render_template :new
    should_respond_with :success
  end

  context "on POST to :create with an invalid email" do
    setup do
      post :create, :email => 'clearly@nouser.bythisemail.com'
    end

    should_render_template :new
    should_respond_with :success
    should_set_the_flash_to(/Aucun utilisateur avec cette adresse email/i)
  end

  context "Given an existing user" do
    setup do
      @person = Factory(:person)
    end

    context "on POST to :create with a valid email" do
      setup do
        post :create, :email => @person.email
      end

      should_change("the password_reset_code field") { @person.reload.password_reset_code}
      should_change("the password_reset_code_expires"){@person.reload.password_reset_code_expires}
      should_render_template :create
      should_respond_with :success
      should_set_the_flash_to(/réinitialiser/i)
    end
  end
end
