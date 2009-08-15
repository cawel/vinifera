require File.dirname(__FILE__) + '<%= ('/..'*model_controller_class_nesting_depth) + '/../spec_helper' %>'
  
# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe <%= model_controller_class_name %>Controller do
  fixtures :<%= table_name %>

  it 'allows signup' do
    lambda do
      create_<%= file_name %>
      response.should be_redirect
    end.should change(<%= class_name %>, :count).by(1)
  end

  <% if options[:stateful] %>
  it 'signs up user in pending state' do
    create_<%= file_name %>
    assigns(:<%= file_name %>).reload
    assigns(:<%= file_name %>).should be_pending
  end<% end %>

<% if options[:include_activation] -%>
  it 'signs up user with activation code' do
    create_<%= file_name %>
    assigns(:<%= file_name %>).reload
    assigns(:<%= file_name %>).activation_code.should_not be_nil
  end<% end -%>

  it 'requires login on signup' do
    lambda do
      create_<%= file_name %>(:login => nil)
      assigns[:<%= file_name %>].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(<%= class_name %>, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_<%= file_name %>(:password => nil)
      assigns[:<%= file_name %>].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(<%= class_name %>, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_<%= file_name %>(:password_confirmation => nil)
      assigns[:<%= file_name %>].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(<%= class_name %>, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_<%= file_name %>(:email => nil)
      assigns[:<%= file_name %>].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(<%= class_name %>, :count)
  end
  
  <% if options[:include_activation] %>
  it 'activates user' do
    <%= class_name %>.authenticate('aaron', 'monkey').should be_nil
    get :activate, :activation_code => <%= table_name %>(:aaron).activation_code
    response.should redirect_to('/login')
    flash[:notice].should_not be_nil
    flash[:error ].should     be_nil
    <%= class_name %>.authenticate('aaron', 'monkey').should == <%= table_name %>(:aaron)
  end
  
  it 'localizates signup message' do
    msg = "Sign up is complete jo!"
    I18n.should_receive(:t).with(:signup_complete_and_do_login).and_return(msg)
    <%= class_name %>.authenticate('aaron', 'monkey').should be_nil
    get :activate, :activation_code => <%= table_name %>(:aaron).activation_code
    flash[:notice].should eql(msg)
  end
  
  it 'localizates blank activation code message' do
      msg = "Missing activation code"
      I18n.should_receive(:t).with(:blank_activation_code).and_return(msg)
      get :activate
      flash[:error].should eql(msg)
  end
  
  it 'does not activate user without key' do
    get :activate
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with blank key' do
    get :activate, :activation_code => ''
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with bogus key' do
    get :activate, :activation_code => 'i_haxxor_joo'
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'localizates bogus activation code message' do
      msg = "Bogus activation code"
      I18n.should_receive(:t).with(:bogus_activation_code, :model => 'user').and_return(msg)
      get :activate, :activation_code => 'i_haxxor_joo'
      flash[:error].should eql(msg)
  end
  
  it "localizates signup with activation message" do
    msg = "Sign up is complete jo!"
    I18n.should_receive(:t).with(:signup_complete_with_activation).and_return(msg)
    create_<%= file_name %>
    flash[:notice].should eql(msg)
  end<% end %>
  
  it "localizates" do
    locale = "pt-BR"
    get :new, :locale => locale
    I18n.locale.should eql(locale)
  end
  
  def create_<%= file_name %>(options = {})
    post :create, :<%= file_name %> => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
  
end

describe <%= model_controller_class_name %>Controller do
  describe "route generation" do
    it "should route <%= model_controller_controller_name %>'s 'index' action correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'index').should == "/<%= model_controller_routing_path %>"
    end
    
    it "should route <%= model_controller_controller_name %>'s 'new' action correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'new').should == "/signup"
    end
    
    it "should route {:controller => '<%= model_controller_controller_name %>', :action => 'create'} correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'create').should == {:path => "/register", :method => :post}
    end
    
    it "should route <%= model_controller_controller_name %>'s 'show' action correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'show', :id => '1').should == "/<%= model_controller_routing_path %>/1"
    end
    
    it "should route <%= model_controller_controller_name %>'s 'edit' action correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'edit', :id => '1').should == "/<%= model_controller_routing_path %>/1/edit"
    end
    
    it "should route <%= model_controller_controller_name %>'s 'update' action correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'update', :id => '1').should == {:path => "/<%= model_controller_routing_path %>/1", :method => :put}
    end
    
    it "should route <%= model_controller_controller_name %>'s 'destroy' action correctly" do
      route_for(:controller => '<%= model_controller_controller_name %>', :action => 'destroy', :id => '1').should == {:path => "/<%= model_controller_routing_path %>/1", :method => :delete}
    end
  end
  
  describe "route recognition" do
    it "should generate params for <%= model_controller_controller_name %>'s index action from GET /<%= model_controller_routing_path %>" do
      params_from(:get, '/<%= model_controller_routing_path %>').should == {:controller => '<%= model_controller_controller_name %>', :action => 'index'}
      params_from(:get, '/<%= model_controller_routing_path %>.xml').should == {:controller => '<%= model_controller_controller_name %>', :action => 'index', :format => 'xml'}
      params_from(:get, '/<%= model_controller_routing_path %>.json').should == {:controller => '<%= model_controller_controller_name %>', :action => 'index', :format => 'json'}
    end
    
    it "should generate params for <%= model_controller_controller_name %>'s new action from GET /<%= model_controller_routing_path %>" do
      params_from(:get, '/<%= model_controller_routing_path %>/new').should == {:controller => '<%= model_controller_controller_name %>', :action => 'new'}
      params_from(:get, '/<%= model_controller_routing_path %>/new.xml').should == {:controller => '<%= model_controller_controller_name %>', :action => 'new', :format => 'xml'}
      params_from(:get, '/<%= model_controller_routing_path %>/new.json').should == {:controller => '<%= model_controller_controller_name %>', :action => 'new', :format => 'json'}
    end
    
    it "should generate params for <%= model_controller_controller_name %>'s create action from POST /<%= model_controller_routing_path %>" do
      params_from(:post, '/<%= model_controller_routing_path %>').should == {:controller => '<%= model_controller_controller_name %>', :action => 'create'}
      params_from(:post, '/<%= model_controller_routing_path %>.xml').should == {:controller => '<%= model_controller_controller_name %>', :action => 'create', :format => 'xml'}
      params_from(:post, '/<%= model_controller_routing_path %>.json').should == {:controller => '<%= model_controller_controller_name %>', :action => 'create', :format => 'json'}
    end
    
    it "should generate params for <%= model_controller_controller_name %>'s show action from GET /<%= model_controller_routing_path %>/1" do
      params_from(:get , '/<%= model_controller_routing_path %>/1').should == {:controller => '<%= model_controller_controller_name %>', :action => 'show', :id => '1'}
      params_from(:get , '/<%= model_controller_routing_path %>/1.xml').should == {:controller => '<%= model_controller_controller_name %>', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/<%= model_controller_routing_path %>/1.json').should == {:controller => '<%= model_controller_controller_name %>', :action => 'show', :id => '1', :format => 'json'}
    end
    
    it "should generate params for <%= model_controller_controller_name %>'s edit action from GET /<%= model_controller_routing_path %>/1/edit" do
      params_from(:get , '/<%= model_controller_routing_path %>/1/edit').should == {:controller => '<%= model_controller_controller_name %>', :action => 'edit', :id => '1'}
    end
    
    it "should generate params {:controller => '<%= model_controller_controller_name %>', :action => update', :id => '1'} from PUT /<%= model_controller_routing_path %>/1" do
      params_from(:put , '/<%= model_controller_routing_path %>/1').should == {:controller => '<%= model_controller_controller_name %>', :action => 'update', :id => '1'}
      params_from(:put , '/<%= model_controller_routing_path %>/1.xml').should == {:controller => '<%= model_controller_controller_name %>', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/<%= model_controller_routing_path %>/1.json').should == {:controller => '<%= model_controller_controller_name %>', :action => 'update', :id => '1', :format => 'json'}
    end
    
    it "should generate params for <%= model_controller_controller_name %>'s destroy action from DELETE /<%= model_controller_routing_path %>/1" do
      params_from(:delete, '/<%= model_controller_routing_path %>/1').should == {:controller => '<%= model_controller_controller_name %>', :action => 'destroy', :id => '1'}
      params_from(:delete, '/<%= model_controller_routing_path %>/1.xml').should == {:controller => '<%= model_controller_controller_name %>', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/<%= model_controller_routing_path %>/1.json').should == {:controller => '<%= model_controller_controller_name %>', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end
  
  describe "named routing" do
    before(:each) do
      get :new
    end
    
    it "should route <%= model_controller_routing_name %>_path() to /<%= model_controller_routing_path %>" do
      <%= model_controller_routing_name %>_path().should == "/<%= model_controller_routing_path %>"
      <%= model_controller_routing_name %>_path(:format => 'xml').should == "/<%= model_controller_routing_path %>.xml"
      <%= model_controller_routing_name %>_path(:format => 'json').should == "/<%= model_controller_routing_path %>.json"
    end
    
    it "should route new_<%= model_controller_routing_name.singularize %>_path() to /<%= model_controller_routing_path %>/new" do
      new_<%= model_controller_routing_name.singularize %>_path().should == "/<%= model_controller_routing_path %>/new"
      new_<%= model_controller_routing_name.singularize %>_path(:format => 'xml').should == "/<%= model_controller_routing_path %>/new.xml"
      new_<%= model_controller_routing_name.singularize %>_path(:format => 'json').should == "/<%= model_controller_routing_path %>/new.json"
    end
    
    it "should route <%= model_controller_routing_name.singularize %>_(:id => '1') to /<%= model_controller_routing_path %>/1" do
      <%= model_controller_routing_name.singularize %>_path(:id => '1').should == "/<%= model_controller_routing_path %>/1"
      <%= model_controller_routing_name.singularize %>_path(:id => '1', :format => 'xml').should == "/<%= model_controller_routing_path %>/1.xml"
      <%= model_controller_routing_name.singularize %>_path(:id => '1', :format => 'json').should == "/<%= model_controller_routing_path %>/1.json"
    end
    
    it "should route edit_<%= model_controller_routing_name.singularize %>_path(:id => '1') to /<%= model_controller_routing_path %>/1/edit" do
      edit_<%= model_controller_routing_name.singularize %>_path(:id => '1').should == "/<%= model_controller_routing_path %>/1/edit"
    end
  end
  
end
