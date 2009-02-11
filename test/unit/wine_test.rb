require 'test_helper'

class WineTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def test_should_not_create_if_name_is_missing
    w = Wine.new(:color_id => colors(:red))
    w.valid?
    assert_not_nil( w.errors['name'] )
  end
  
  should_belong_to :person
  should_belong_to :color

  should_validate_presence_of :name, :color_id, :person_id
  
  should_have_many :reviews, :dependent => :destroy
  should_have_many :variety_wines
  should_have_many :varieties, :through => :variety_wines
end
