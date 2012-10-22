class TimelineEventsController < ApplicationController

  def index

    @page_title = "Le Tastevin: nos critiques de vin"

    respond_to do |format|
      @timeline_events = TimelineEvent.recent
      format.html
      format.rss do  
        render :layout => false 
      end 
    end 
  end

end 
