module ApplicationHelper

  def show_map(reports)
    buffer = <<-JS
      var map = new GMap2(document.getElementById('map'));
      map.setCenter(new GLatLng(29.25, -86.75), 7);
      map.addControl(new GSmallMapControl());
    JS

    reports.collect(&:hew).each do |report|
      buffer << %Q(map.addOverlay(createMarker(map, #{report.to_json}));\n)
    end

    buffer
  end

  def coderay(text)
    text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
      content_tag("notextile", CodeRay.scan($3, $2).div(:css => :class))
    end
  end
  
end
