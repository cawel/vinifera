require File.dirname(__FILE__) + '/../test_helper'

class ReviewTest < Test::Unit::TestCase
  should_belong_to :wine
  should_belong_to :person
  should_belong_to :rating
  
  should_validate_presence_of :rating_id
  should_validate_presence_of :person_id
  should_validate_presence_of :comment
end