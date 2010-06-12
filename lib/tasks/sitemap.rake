namespace :sitemap do
  task :generate => :environment do
    sitemap = Sitemap.create!('http://oilreporter.org')
  end
end