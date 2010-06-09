require File.dirname(__FILE__) + '/../../test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  context "linking links in the Twitter feed" do

    context "when there are no links whatsoever" do
      setup do
        @raw = "There is no link"
      end
      should "link the link" do
        assert_equal %{There is no link}, link_links(@raw)
      end
    end

    context "when there is 1 link at the end" do
      setup do
        @raw = "This link is cool: http://cnn.com"
      end
      should "link the link" do
        assert_equal %{This link is cool: <a href="http://cnn.com">http://cnn.com</a>}, link_links(@raw)
      end
    end

    context "when there is 1 link not at the end" do
      setup do
        @raw = "This link is cool: http://cnn.com yeah?"
      end
      should "link the link" do
        assert_equal %{This link is cool: <a href="http://cnn.com">http://cnn.com</a> yeah?}, link_links(@raw)
      end
    end

    context "when there are 2 links in it" do
      setup do
        @raw = "This link is cool: http://cnn.com and this one too: http://google.com"
      end
      should "link the links" do
        assert_equal %{This link is cool: <a href="http://cnn.com">http://cnn.com</a> and this one too: <a href="http://google.com">http://google.com</a>}, link_links(@raw)
      end
    end
  end
end
