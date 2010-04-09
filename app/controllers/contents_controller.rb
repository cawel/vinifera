class ContentsController < ApplicationController

  require 'simple-rss'
  require 'open-uri'

  def contact
  end

  def about
  end

  def ratings_help
  end

  def feed
    url = "http://pipes.yahoo.com/pipes/pipe.run?_id=0183129386d42d4a011bd5692f8f63f4&_render=rss"
    @feed = SimpleRSS.parse open(url)
  end

end
