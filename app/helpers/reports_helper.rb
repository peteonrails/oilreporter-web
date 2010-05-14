module ReportsHelper  
  
  def google_maps_js
    key_pair = "key=#{Oilreporter.config.google_api_key}" if Oilreporter.config.google_api_key   
    "<script type='text/javascript' src='http://maps.google.com/maps?file=api&amp;#{key_pair}'></script>"
  end

  def map_javascripts
    if @map_javascripts_displayed
      return
    else
      @map_javascripts_displayed = true
      return google_maps_js
    end
  end

end