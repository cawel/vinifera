require File.dirname(__FILE__) + '/../spec_helper'
include ApplicationHelper
include PeopleHelper
include AuthenticatedTestHelper

describe PeopleHelper do
  before do
    @person = mock_person
  end
  
  describe "if_authorized" do 
    it "yields if authorized" do
      should_receive(:authorized?).with('a','r').and_return(true)
      if_authorized?('a','r'){|action,resource| [action,resource,'hi'] }.should == ['a','r','hi']
    end
    it "does nothing if not authorized" do
      should_receive(:authorized?).with('a','r').and_return(false)
      if_authorized?('a','r'){ 'hi' }.should be_nil
    end
  end
  
  describe "link_to_person" do
    it "should give an error on a nil person" do
      lambda { link_to_person(nil) }.should raise_error('Invalid person')
    end
    it "should link to the given person" do
      should_receive(:person_path).at_least(:once).and_return('/people/1')
      link_to_person(@person).should have_tag("a[href='/people/1']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_person(@person, :content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_person(@person).should have_tag("a", 'user_name')
    end
    it "should use the name as link text with :content_method => :name" do
      link_to_person(@person, :content_method => :name).should have_tag("a", 'U. Surname')
    end
    it "should use the login as title with no :title_method specified" do
      link_to_person(@person).should have_tag("a[title='user_name']")
    end
    it "should use the name as link title with :content_method => :name" do
      link_to_person(@person, :title_method => :name).should have_tag("a[title='U. Surname']")
    end
    it "should have nickname as a class by default" do
      link_to_person(@person).should have_tag("a.nickname")
    end
    it "should take other classes and no longer have the nickname class" do
      result = link_to_person(@person, :class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

  describe "link_to_login_with_IP" do
    it "should link to the login_path" do
      link_to_login_with_IP().should have_tag("a[href='/login']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_login_with_IP('Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_login_with_IP().should have_tag("a", '0.0.0.0')
    end
    it "should use the ip address as title" do
      link_to_login_with_IP().should have_tag("a[title='0.0.0.0']")
    end
    it "should by default be like school in summer and have no class" do
      link_to_login_with_IP().should_not have_tag("a.nickname")
    end
    it "should have some class if you tell it to" do
      result = link_to_login_with_IP(nil, :class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
    it "should have some class if you tell it to" do
      result = link_to_login_with_IP(nil, :tag => 'abbr')
      result.should have_tag("abbr[title='0.0.0.0']")
    end
  end

  describe "link_to_current_person, When logged in" do
    before do
      stub!(:current_person).and_return(@person)
    end
    it "should link to the given person" do
      should_receive(:person_path).at_least(:once).and_return('/people/1')
      link_to_current_person().should have_tag("a[href='/people/1']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_current_person(:content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use the login as link text with no :content_method specified" do
      link_to_current_person().should have_tag("a", 'user_name')
    end
    it "should use the name as link text with :content_method => :name" do
      link_to_current_person(:content_method => :name).should have_tag("a", 'U. Surname')
    end
    it "should use the login as title with no :title_method specified" do
      link_to_current_person().should have_tag("a[title='user_name']")
    end
    it "should use the name as link title with :content_method => :name" do
      link_to_current_person(:title_method => :name).should have_tag("a[title='U. Surname']")
    end
    it "should have nickname as a class" do
      link_to_current_person().should have_tag("a.nickname")
    end
    it "should take other classes and no longer have the nickname class" do
      result = link_to_current_person(:class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

  describe "link_to_current_person, When logged out" do
    before do
      stub!(:current_person).and_return(nil)
    end
    it "should link to the login_path" do
      link_to_current_person().should have_tag("a[href='/login']")
    end
    it "should use given link text if :content_text is specified" do
      link_to_current_person(:content_text => 'Hello there!').should have_tag("a", 'Hello there!')
    end
    it "should use localized :not_signed_in as link text with no :content_method specified" do
      msg = "not signed in 123"
      I18n.should_receive(:t).with(:not_signed_in).and_return(msg)
      link_to_current_user().should have_tag("a", msg)
    end
    it "should use the ip address as title" do
      link_to_current_person().should have_tag("a[title='0.0.0.0']")
    end
    it "should by default be like school in summer and have no class" do
      link_to_current_person().should_not have_tag("a.nickname")
    end
    it "should have some class if you tell it to" do
      result = link_to_current_person(:class => 'foo bar')
      result.should have_tag("a.foo")
      result.should have_tag("a.bar")
    end
  end

end
