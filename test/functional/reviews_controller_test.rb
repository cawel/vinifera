require File.dirname(__FILE__) + '/../test_helper'
require 'reviews_controller'

# Re-raise errors caught by the controller.
class ReviewsController; def rescue_action(e) raise e end; end

class ReviewsControllerTest < Test::Unit::TestCase
  def setup
    @controller           = ReviewsController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @review = reviews :good_wine
  end

  should_be_restful do |resource|
    resource.formats = [:html]
  end
  

end
