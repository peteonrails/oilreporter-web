module ApplicationHelper

  def show_map(reports)
    buffer = <<-JS
      var map = new GMap2(document.getElementById('map'));
      map.setCenter(new GLatLng(29.19042, -88.7649), 7);
      map.addControl(new GSmallMapControl());
      map.addControl(new GMapTypeControl());
      map.enableScrollWheelZoom();
      map.setMapType(G_HYBRID_MAP);
    JS

    reports.collect(&:hew).each do |report|
      buffer << %Q(map.addOverlay(createMarker(map, #{report.to_json}));\n)
    end

    buffer
  end
  
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

  def coderay(text)
    text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
      content_tag("notextile", CodeRay.scan($3, $2).div(:css => :class))
    end
  end
  
  def footer
    render :partial => 'shared/footer'
  end
  
  def header
    render :partial => 'shared/header'
  end

  def javascripts
    render :partial => 'shared/javascripts'
  end
  
  def twitter
    render :partial => 'shared/twitter'
  end
  
  def search
    render :partial => 'shared/search'
  end
  
  def markers
    render :partial => 'shared/markers'
  end
  
  def welcome_popup
    render :partial => 'shared/welcome_popup'
  end
  
end