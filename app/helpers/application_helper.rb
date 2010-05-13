module ApplicationHelper
  def body_class
    [:notice, :warning, :message, :error].collect do |key|
      content_tag(:div, content_tag(:p, flash[key]), :id => "flash", :class => "message message-#{key}") unless flash[key].blank?
    end.join
  end
  
  def get_twitter_buzz
    results = []
    %w{#oilspill}.each do |q|
      tsearch = Twitter::Search.new(q)
      tresponse = tsearch.fetch
      results << tresponse.results[1..3]
    end
    results.flatten.compact
  end

  def show_map(reports)
    buffer = <<-JS
      var map = new GMap2(document.getElementById('map'));
      map.setCenter(new GLatLng(29.25, -86.75), 7);
    JS

    reports.each do |report|
      buffer << %Q(map.addOverlay(createMarker(map, #{report.jsonify}));\n)
    end

    buffer
  end

  def coderay(text)
    text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
      content_tag("notextile", CodeRay.scan($3, $2).div(:css => :class))
    end
  end
  
end
