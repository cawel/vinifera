xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do   
  xml.channel do               
    xml.title       "Le-Tastevin.com: Flux de l'activité"
    xml.description "Récente activité sur le site"
    xml.link        root_url   

    @timeline_events.each do |e|    
      case e.event_type
      when 'edited'
        wine = e.subject.wine
        title = "Critique modifiée par #{person_display_name(e.actor)} de: #{wine.name}"   
      when 'reviewed'
        wine = e.subject.wine
        title = "Nouvelle critique de #{person_display_name(e.actor)} de: #{wine.name}"   
      when 'cellar_wine_created'
        wine = e.subject
        title = "Ajout dans le cellier de #{person_display_name(e.actor)} de: #{wine.name}"   
      end

      xml.item do              
        xml.title       title
        if e.event_type != 'cellar_wine_created'
          xml.description "#{e.subject.comment}"
        end
        xml.pubDate     e.created_at.to_s(:rfc822)
        xml.link        wine_reviews_url(wine)
      end
    end
  end
end 
