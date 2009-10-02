class TimelineEventsController < ApplicationController

  def index
    respond_to do |format|
      @timeline_events = TimelineEvent.recent
      format.html
      format.rss do  
        render :layout => false 
      end 
    end 
  end

end 
