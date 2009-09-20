require File.dirname(__FILE__) + '/../test_helper'

class WineTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def test_should_not_create_if_name_is_missing
    w = Wine.new(:color_id => colors(:red))
    w.valid?
    assert_not_nil( w.errors['name'] )
  end
  
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
