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
  

  
end
