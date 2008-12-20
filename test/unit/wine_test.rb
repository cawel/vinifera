require 'test_helper'

class WineTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def test_should_not_create_if_name_is_missing
    w = Wine.new(:color_id => colors(:red))
    w.valid?
    assert_not_nil( w.errors['name'] )
  end

end
