xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do   
  xml.channel do               
    xml.title       "Le-Tastevin.com: Dernières critiques"
    xml.description "Dernières critiques de vin"
    xml.link        root_url   

    @timeline_events.each do |e|    
      verb = 'fait'
      if e.event_type == 'edited'
        verb = 'édité'
      end

      xml.item do              
        xml.title       "#{person_display_name(e.actor)} a #{verb} une critique de: #{e.subject.wine.name}"   
        xml.description "#{e.subject.comment}"
        xml.pubDate     e.created_at.to_s(:rfc822)
        xml.link        wine_reviews_url(e.subject.wine)
      end
    end
  end
end 
