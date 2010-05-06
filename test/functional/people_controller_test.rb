require File.dirname(__FILE__) + '/../test_helper'

class PeopleControllerTest < ActionController::TestCase
  not_logged_in do
    context "on GET to :new" do
      setup do
        get :new
      end

      should_respond_with :success
      should_render_template "new"
      should_not_set_the_flash
      should_render_a_form

      should "have good old fashioned way of login in" do
        assert_form people_path, :post do
          assert_text_field     :person, :email
          assert_password_field :person, :password
          assert_password_field :person, :password_confirmation
          assert_submit
        end
      end

    end

    context "on POST to :create with invalid attributes" do
      setup do
        post :create, :person => Factory.attributes_for(:person, :password_confirmation => "not the same password")
      end

      should_respond_with :success
      should_render_template "new"
      should_not_set_the_flash
      should_render_a_form
    end

    context "on POST to :create with valid attributes" do
      setup do
        post :create, :person => Factory.attributes_for(:person)
      end

      should_redirect_to("the homepage") { root_url }
      #should_set_the_flash_to /thanks/i
      should "authenticate the new person" do
        assert_not_nil session[:person_id]
      end
    end

  end

  logged_in_as :mat do

    context "on PUT to :update with valid attributes" do
      setup do
        @user = people(:mat)
        put :update, :id => @user.id, :person => { :name => "new name", :description => "my new description" }
        @user.reload
      end

      should "set the new description" do
        @user.reload
        assert_equal "new name", @user.name
        assert_equal "my new description", @user.description
      end

      should_assign_to :person
      should_respond_with :redirect
      should_redirect_to("the user's profile") {person_path(@user)}
    end

    context "on PUT to :update another user's profile" do
      setup do
        @user = people(:james)
        put :update, :id => @user.id, :person => { :name => "new name", :description => "my new description" }
      end

      should_redirect_to("your own user profile") { person_path(people(:mat)) }
    end

    context "on GET to :edit another user's profile" do
      setup do
        @user = people(:james)
        get :edit, :id => @user.id
      end

      should_redirect_to("your own user profile") { person_path(people(:mat)) }
    end
  end

end
