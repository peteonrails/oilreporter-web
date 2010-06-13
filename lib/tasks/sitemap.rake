namespace :sitemap do
  task :generate => :environment do
    include ActionView::Helpers::NumberHelper

    sitemap = Sitemap.instance.create!(:output => $stdout, :save => true, :notify => true)
    puts "Generated sitemap is #{number_to_human_size(sitemap.unpack('C*').size)}"
  end
end