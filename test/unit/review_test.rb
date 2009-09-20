require File.dirname(__FILE__) + '/../test_helper'

class ReviewTest < Test::Unit::TestCase
  should_belong_to :wine
  should_belong_to :person
  should_belong_to :rating
  
  should_validate_presence_of :rating_id
  should_validate_presence_of :person_id
  should_validate_presence_of :comment

  context "the top contributers" do
    setup do
      @top = Review.top_contributers
    end
    should "be a list" do
      assert @top.is_a? Array
    end
    should "be a list of users" do 
      assert @top.first.respond_to? :name
    end
    should "contain a review count" do
      assert @top.first.respond_to? :review_count
    end
  end
end
