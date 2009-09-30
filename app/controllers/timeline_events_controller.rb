class TimelineEventsController < ApplicationController

  def index
    respond_to do |format|
        @timeline_events = TimelineEvent.recent
      format.rss do  
        render :layout => false 
      end 
      format.html do
        render :layout => 'application'
      end
    end 
  end

end 
