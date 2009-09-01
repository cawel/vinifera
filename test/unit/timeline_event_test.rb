require File.dirname(__FILE__) + '/../test_helper'

class TimelineEventTest < ActiveSupport::TestCase

  context "Reviewing on a wine" do
    setup do
      @martin = people(:martin)
      @rating = ratings(:stars2)
      @wine = wines(:chateau_coulac)
      Review.create(:person_id => @martin.id, :rating_id => @rating.id, :wine_id => @wine.id,  :comment => "Good good wine!")
    end

    should_change "TimelineEvent.count", :by => 1

    context "the timeline event" do
      setup do
        @event = TimelineEvent.last
      end
      should "set the actor to be the person who did the review" do
        assert_equal @martin, @event.actor
      end

      should "set the subject to be the wine which was reviewed" do
        assert_equal @wine, @event.subject
      end

      should "set the event type to be 'friended'" do
        assert_equal "reviewed", @event.event_type
      end
    end
  end


  context "Editing the review of a wine" do
    setup do
      @review = reviews(:wine2_according_to_martin)
      @review.update_attributes(:comment => "this is my changed review")
    end

    should_change "TimelineEvent.count", :by => 1

    context "the timeline event" do
      setup do
        @event = TimelineEvent.last
      end
      should "set the actor to be the person who edited the review" do
        assert_equal @martin, @event.actor
      end

      should "set the subject to be the wine which was reviewed" do
        assert_equal @wine, @event.subject
      end

      should "set the event type to be 'friended'" do
        assert_equal "edited", @event.event_type
      end
    end
  end

end
