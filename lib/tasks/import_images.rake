# file: validate_models.rake
# task: rake db:validate_models
require 'net/http'

namespace :db do
  desc "Download and import the images for a production-loaded database. To be run immediately after 'heroku db:pull'."
  task :import_images => :environment do
    include ActionView::Helpers::NumberHelper

    files, size = 0, 0
    Report.within_oil_spill.select(&:media?).each do |report|
      url = URI.parse("http://s3.amazonaws.com/oilspill_photos/medias/#{report.id}/original.jpeg")

      begin
        response = Net::HTTP.start(url.host, url.port) do |http|
          http.read_timeout = 5
          http.get(url.path)
        end
        case response
        when Net::HTTPSuccess
          local_file = "/tmp/#{report.id}.jpeg"
          open(local_file, "wb") { |file|
            file.write(response.body)
          }
          report.media = open(local_file)
          report.save!
          size += report.media.size
          files += 1
          puts "Attached media to report #{report.id}"
        else
          puts "Failure to download media for report #{report.id}"
        end
      rescue Timeout::Error => error
        puts "Timeout error for report #{report.id}"
      rescue ActiveRecord::RecordInvalid => error
        puts "Could not save report #{report.id} #{error}"
      end # begin
    end # Report
    
    puts "Downloaded #{number_to_human_size(size)} total, attached media to #{files} reports"
  end
end
