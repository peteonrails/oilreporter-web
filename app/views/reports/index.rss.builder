xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Latest Oil Reports"
    xml.description "The most recent updates from people reporting near the Gulf of Mexico."
    xml.link reports_url
    
    for report in @reports
      xml.item do
        xml.title report.description
        xml.description "Wildlife: #{report.wildlife}, Oil: #{report.oil} out of 10, Wetlands: #{report.wetlands} out of 10, <a href=\"http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=#{report.latitude},#{report.longitude}&z=9\" target=\"_blank\">View Map</a>"
        xml.pubDate report.created_at.to_s(:rfc822)
        xml.link reports_url
      end
    end
  end
end