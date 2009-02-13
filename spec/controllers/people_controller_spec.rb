require File.dirname(__FILE__) + '/../spec_helper'
  
# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe PeopleController do
  fixtures :people

  it 'allows signup' do
    lambda do
      create_person
      response.should be_redirect
    end.should change(Person, :count).by(1)
  end

  


  it 'requires login on signup' do
    lambda do
      create_person(:login => nil)
      assigns[:person].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_person(:password => nil)
      assigns[:person].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_person(:password_confirmation => nil)
      assigns[:person].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_person(:email => nil)
      assigns[:person].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Person, :count)
  end
  
  
  
  it "localizates" do
    locale = "pt-BR"
    get :new, :locale => locale
    I18n.locale.should eql(locale)
  end
  
  def create_person(options = {})
    post :create, :person => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
  
end

describe PeopleController do
  describe "route generation" do
    it "should route peoples's 'index' action correctly" do
      route_for(:controller => 'peoples', :action => 'index').should == "/people"
    end
    
    it "should route peoples's 'new' action correctly" do
      route_for(:controller => 'peoples', :action => 'new').should == "/signup"
    end
    
    it "should route {:controller => 'peoples', :action => 'create'} correctly" do
      route_for(:controller => 'peoples', :action => 'create').should == "/register"
    end
    
    it "should route peoples's 'show' action correctly" do
      route_for(:controller => 'peoples', :action => 'show', :id => '1').should == "/people/1"
    end
    
    it "should route peoples's 'edit' action correctly" do
      route_for(:controller => 'peoples', :action => 'edit', :id => '1').should == "/people/1/edit"
    end
    
    it "should route peoples's 'update' action correctly" do
      route_for(:controller => 'peoples', :action => 'update', :id => '1').should == "/people/1"
    end
    
    it "should route peoples's 'destroy' action correctly" do
      route_for(:controller => 'peoples', :action => 'destroy', :id => '1').should == "/people/1"
    end
  end
  
  describe "route recognition" do
    it "should generate params for peoples's index action from GET /people" do
      params_from(:get, '/people').should == {:controller => 'peoples', :action => 'index'}
      params_from(:get, '/people.xml').should == {:controller => 'peoples', :action => 'index', :format => 'xml'}
      params_from(:get, '/people.json').should == {:controller => 'peoples', :action => 'index', :format => 'json'}
    end
    
    it "should generate params for peoples's new action from GET /people" do
      params_from(:get, '/people/new').should == {:controller => 'peoples', :action => 'new'}
      params_from(:get, '/people/new.xml').should == {:controller => 'peoples', :action => 'new', :format => 'xml'}
      params_from(:get, '/people/new.json').should == {:controller => 'peoples', :action => 'new', :format => 'json'}
    end
    
    it "should generate params for peoples's create action from POST /people" do
      params_from(:post, '/people').should == {:controller => 'peoples', :action => 'create'}
      params_from(:post, '/people.xml').should == {:controller => 'peoples', :action => 'create', :format => 'xml'}
      params_from(:post, '/people.json').should == {:controller => 'peoples', :action => 'create', :format => 'json'}
    end
    
    it "should generate params for peoples's show action from GET /people/1" do
      params_from(:get , '/people/1').should == {:controller => 'peoples', :action => 'show', :id => '1'}
      params_from(:get , '/people/1.xml').should == {:controller => 'peoples', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/people/1.json').should == {:controller => 'peoples', :action => 'show', :id => '1', :format => 'json'}
    end
    
    it "should generate params for peoples's edit action from GET /people/1/edit" do
      params_from(:get , '/people/1/edit').should == {:controller => 'peoples', :action => 'edit', :id => '1'}
    end
    
    it "should generate params {:controller => 'peoples', :action => update', :id => '1'} from PUT /people/1" do
      params_from(:put , '/people/1').should == {:controller => 'peoples', :action => 'update', :id => '1'}
      params_from(:put , '/people/1.xml').should == {:controller => 'peoples', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/people/1.json').should == {:controller => 'peoples', :action => 'update', :id => '1', :format => 'json'}
    end
    
    it "should generate params for peoples's destroy action from DELETE /people/1" do
      params_from(:delete, '/people/1').should == {:controller => 'peoples', :action => 'destroy', :id => '1'}
      params_from(:delete, '/people/1.xml').should == {:controller => 'peoples', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/people/1.json').should == {:controller => 'peoples', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end
  
  describe "named routing" do
    before(:each) do
      get :new
    end
    
    it "should route people_path() to /people" do
      people_path().should == "/people"
      formatted_people_path(:format => 'xml').should == "/people.xml"
      formatted_people_path(:format => 'json').should == "/people.json"
    end
    
    it "should route new_person_path() to /people/new" do
      new_person_path().should == "/people/new"
      formatted_new_person_path(:format => 'xml').should == "/people/new.xml"
      formatted_new_person_path(:format => 'json').should == "/people/new.json"
    end
    
    it "should route person_(:id => '1') to /people/1" do
      person_path(:id => '1').should == "/people/1"
      formatted_person_path(:id => '1', :format => 'xml').should == "/people/1.xml"
      formatted_person_path(:id => '1', :format => 'json').should == "/people/1.json"
    end
    
    it "should route edit_person_path(:id => '1') to /people/1/edit" do
      edit_person_path(:id => '1').should == "/people/1/edit"
    end
  end
  
end
