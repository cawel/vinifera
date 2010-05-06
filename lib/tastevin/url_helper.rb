module Tastevin
  module UrlHelper

    def seo_friendlize url
      url.gsub(/[èéêë]/,'e').gsub(/[àáâãäå]/,'a').gsub(/æ/,'ae').gsub(/ô/, 'o').gsub(/ç/, 'c').gsub(/[^a-z0-9]+/i, '-').downcase
    end

  end
end
