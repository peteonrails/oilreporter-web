require 'builder'

class Sitemap
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlWriter
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  include Singleton

  attr_accessor :options

  def create!(_options = {})
    @options = { :url => "http://oilreporter.org",
                 :notify => false,
                 :save => false,
                 :output => Rails.logger }.merge(_options)
    options[:url].slice!(-1) if /\/$/ === options[:url]

    result = generate_sitemap
    options[:notify] && notify_search_engines
    options[:save] && save(result)

    result
  end

  private

  def domain
    options[:url][/([a-z0-9-]+)\.([a-z.]+)/i]
  end

  def static_urls
    [
     ['', 'home/index', 'monthly'],
     ['blog', Post.published.last.updated_at, 'weekly'],
     ['reports', Report.within_oil_spill.last.updated_at, 'daily'],
     ['news', 'home/news', 'weekly'],
     ['signup', 'developers/new', 'monthly'],
     ['organizations/new', 'organizations/new', 'monthly'],
     ['tools', 'home/tools', 'monthly'],
     ['map', Report.within_oil_spill.last.updated_at, 'daily'],
     ['data-sources', 'home/data_sources', 'monthly'],
     ['api', 'home/api', 'monthly']
    ]
  end

  def generate_sitemap
    result = ""
    xml = Builder::XmlMarkup.new(:target => result, :indent => 2)

    xml.instruct!
    xml.urlset(:xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
      static_urls.each do |loc, path_or_time, freq|
        xml.url do
          xml.loc("#{options[:url]}/#{loc}")
          xml.changefreq freq
          xml.priority '0.1'

          if path_or_time.is_a?(String)
            xml.lastmod(File.mtime(File.join(Rails.root, 'app/views', "#{path_or_time}.haml")).xmlschema)
          else
            xml.lastmod(path_or_time.xmlschema)
          end
        end
      end # static_urls

      Report.within_oil_spill.each do |report|
        xml.url do
          xml.loc "#{options[:url]}#{report_link(report)}"
          xml.changefreq 'monthly'
          xml.priority '0.9'
          xml.lastmod report.updated_at.xmlschema
        end
      end # Report

      Post.published.each do |post|
        xml.url do
          xml.loc "#{options[:url]}#{post_link(post)}"
          xml.changefreq 'monthly'
          xml.priority '0.8'
          xml.lastmod post.updated_at.xmlschema
        end
      end # Post
    end # urlset

    return result
  end

  def save(xml)
    File.open("#{Rails.root}/public/sitemap.xml", "w") do |f|
      f.write(xml)
    end
  end

  # Notify popular search engines of the updated sitemap.xml
  def notify_search_engines
    return if RAILS_ENV != 'production'

    escaped_uri = CGI.escape("#{options[:url]}/sitemap.xml")

    [
      ['Google', 'www.google.com/webmasters/tools/ping?sitemap='],
      ['Yahoo', 'search.yahooapis.com/SiteExplorerService/V1/updateNotification?appid=SitemapWriter&url='],
      ['Bing', 'www.bing.com/webmaster/ping.aspx?siteMap='],
      ['Ask', 'submissions.ask.com/ping?sitemap=']
    ].each do |site|
      engine, submit_url = site
      url = URI.parse("http://#{submit_url}#{escaped_uri}")

      begin
        response = Net::HTTP.start(url.host, url.port) do |http|
          http.read_timeout = 5
          http.get(url.path)
        end
        case response
        when Net::HTTPSuccess
          options[:output] << "Successfully notified #{engine}\n"
        else
          options[:output] << "Failed to notify #{engine}\n"
        end
      rescue Timeout::Error => error
        options[:output] << "Timeout while attempting to notify #{engine}\n"
      end # begin
    end # each
  end # update_search_engines

end # Sitemap
