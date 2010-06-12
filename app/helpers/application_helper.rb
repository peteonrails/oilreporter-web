module ApplicationHelper

  def show_map(reports)
    buffer = <<-JS
      var map = new GMap2(document.getElementById('map'));
      map.setCenter(new GLatLng(27.897349, -86.923828), 6);
      map.addControl(new GSmallMapControl());
      map.addControl(new GMapTypeControl());
      map.enableScrollWheelZoom();
      map.setMapType(G_HYBRID_MAP);
    JS

    reports.collect(&:hew).each do |report|
      buffer << %Q(map.addOverlay(createMarker(map, #{report.to_json}));\n)
    end

    buffer << %Q(var oilSpill = new GGeoXml("http://mw1.google.com/mw-earth-vectordb/disaster/gulf_oil_spill/kml/noaa/nesdis_anomaly_rs2.kml");\n);
    buffer << %Q(map.addOverlay(oilSpill);\n)

    buffer
  end

  def detailed_map(report)
    buffer = <<-JS
      var map = new GMap2(document.getElementById('map'));
      map.setCenter(new GLatLng(#{report.latitude}, #{report.longitude}), 6);
      map.addControl(new GSmallMapControl());
      map.addControl(new GMapTypeControl());
      map.enableScrollWheelZoom();
      map.setMapType(G_HYBRID_MAP);
      map.addOverlay(createMarker(map, #{report.hew.to_json}));
    JS
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

  def kml_text(report)
    buffer = [:description, :oil, :wetlands, :wildlife].collect do |field|
      value = report.send(field)
      value = value.to_s.strip if value.respond_to?(:to_s)
      value.blank? ? '' : content_tag('strong', "#{field.to_s.titleize}: ") + value
    end
    buffer = buffer.join('<br />')
    "\n#{buffer}\n"
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
  
  def current_year
    Date.today.year
  end
  
  def sanitize_feed_content(html, sanitize_tables = false)
    options = sanitize_tables ? {} : {:tags => %w(table thead tfoot tbody td tr th)}
    returning h(sanitize(html.strip, options)) do |html|
      html.gsub! /&amp;(#\d+);/ do |s|
        "&#{$1};"
      end
    end
  end
  
  def body_class
    klass = []
    klass << controller.controller_class_name
    klass << controller.action_name
    klass << controller.controller_name + '_' + controller.action_name
    klass << params[:page_url].underscore if params[:page_url]
    return klass.join(' ')
  end
  
end