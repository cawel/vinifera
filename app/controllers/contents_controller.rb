class ContentsController < ApplicationController

  require 'simple-rss'
  require 'open-uri'

  caches_page :twitter_feed

  def contact
  end

  def about
  end

  def ratings_help
  end

  def wine_news
    url = "http://pipes.yahoo.com/pipes/pipe.run?_id=0183129386d42d4a011bd5692f8f63f4&_render=rss"
    @feed = SimpleRSS.parse open(url)
  end

  def twitter_feed
     raw_twitter_feed = open "https://api.twitter.com/1/statuses/user_timeline.rss?screen_name=le_tastevin"
    # raw_twitter_feed = File.read(File.join(RAILS_ROOT, "test/feeds/twitter_feed.rss"))
    @twitter_feed = SimpleRSS.parse(raw_twitter_feed)
    render :layout => false
  end

end
