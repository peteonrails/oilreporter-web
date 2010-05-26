xml.instruct! :xml, :version => "1.0" 
xml.rss (:version => "2.0", "xmlns:georss" => "http://www.georss.org/georss") do
  xml.channel do
    xml.title "Latest Oil Reports"
    xml.description "The most recent updates from people reporting near the Gulf of Mexico."
    xml.link reports_url
    
    for report in @reports
      xml.item do
        xml.title report.description
        xml.description "Wildlife: #{report.wildlife}, Oil: #{report.oil} out of 10, Wetlands: #{report.wetlands} out of 10"
        xml.pubDate report.created_at.to_s(:rfc822)
        xml.link reports_url
        xml.georss :point do
          xml.text! report.latitude.to_s + ' ' + report.longitude.to_s
        end
      end
    end
  end
end