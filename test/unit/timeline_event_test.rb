require File.dirname(__FILE__) + '/../test_helper'

class TimelineEventTest < ActiveSupport::TestCase

  context "Adding a wine to the cellar" do
    setup do
      @mat = people(:mat)
      @wine = wines(:chateau_coulac)
      CellarWine.create(:person_id => @mat.id, :wine_id => @wine.id)
    end
    should_change("the TimelineEvent count", :by => 1) { TimelineEvent.count}
    context "the timeline event" do
      setup do
        @event = TimelineEvent.last
      end

      should "set the actor to be the person who did the review" do
        assert_equal @mat, @event.actor
      end

      should "set the subject to be the wine which was added to the cellar" do
        assert_equal @wine, @event.subject
      end

      should "set the event type to be 'cellar_wine_created'" do
        assert_equal "cellar_wine_created", @event.event_type
      end
    end
  end

  context "Reviewing on a wine" do
    setup do
      @mat = people(:mat)
      @rating = ratings(:stars2)
      @wine = wines(:chateau_coulac)
      @review = Review.create(:person_id => @mat.id, :rating_id => @rating.id, :wine_id => @wine.id,  :comment => "Good good wine!")
    end

    should_change("the TimelineEvent count", :by => 1) { TimelineEvent.count}

    context "the timeline event" do
      setup do
        @event = TimelineEvent.last
      end
      should "set the actor to be the person who did the review" do
        assert_equal @mat, @event.actor
      end

      should "set the subject to be the review" do
        assert_equal @review, @event.subject
      end

      should "set the event type to be 'reviewed'" do
        assert_equal "reviewed", @event.event_type
      end
    end
  end


  context "Editing the review of a wine" do
    setup do
      @review = reviews(:wine2_according_to_mat)
      @review.update_attributes(:comment => "this is my changed review")
    end

    should_change("the TimelineEvent count", :by => 1) { TimelineEvent.count }

    context "the timeline event" do
      setup do
        @event = TimelineEvent.last
      end
      should "set the actor to be the person who edited the review" do
        assert_equal @mat, @event.actor
      end

      should "set the subject to be the wine which was reviewed" do
        assert_equal @review, @event.subject
      end

      should "set the event type to be 'friended'" do
        assert_equal "edited", @event.event_type
      end
    end
  end

end
