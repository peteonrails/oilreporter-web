xml.instruct! :xml, :version => "1.0"
xml.kml(:xmlns => "http://www.opengis.net/kml/2.2") do
  xml.Document do
    for report in @reports
      xml.Placemark do
        xml.name report.created_at.to_s(:short_date)
        xml.description {
          xml.cdata!(kml_text(report))
        }
        xml.Point {
          xml.coordinates "#{report.longitude}, #{report.latitude}"
        }
      end
    end
  end
end
