xml.instruct! :xml, :version => "1.0"
xml.kml(:xmlns => "http://www.opengis.net/kml/2.2") do
  xml.Document do
    for report in @reports
      xml.Placemark do
        xml.name report.created_at.to_s(:short_date)
        xml.atom :author do
          xml.atom :name do
            xml.text! "OilReporter.org"
          end
        end
        xml.atom :link, :href => "http://oilreporter.org"
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
