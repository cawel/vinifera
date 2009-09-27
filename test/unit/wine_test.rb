require File.dirname(__FILE__) + '/../test_helper'

class WineTest < ActiveSupport::TestCase
  
  should_belong_to :person
  should_belong_to :color
  should_belong_to :country
  
  should_validate_presence_of :name, :color_id, :person_id
  
  should_have_many :reviews, :dependent => :destroy
  should_have_many :variety_wines
  should_have_many :varieties, :through => :variety_wines

  context "the top wines" do
    setup do
      @top = Wine.top_wines
    end
    should "be a list of wines" do
      assert @top.is_a? Array
      assert @top.first.is_a? Wine
    end
  end
end
