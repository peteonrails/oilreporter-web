class HomeController < ApplicationController
  
  ENABLE_FEATURED_POSTS = true;
  
  def sitemap
    sitemap = Sitemap.create!('http://oilreporter.org')
    render :xml => sitemap
  end
  
  def setup
    add_crumb "setup", '/setup'
  end
  
  def api
    add_crumb "api", '/api'
  end
  
  def tools
    add_crumb "tools", '/tools'
  end
  
  def about
    add_crumb "about", '/about'
  end
  
  def privacy
    add_crumb "privacy", '/privacy'
  end
  
  def data_sources
    add_crumb "data sources", '/data-sources'
  end
  
  def tos
    add_crumb "terms of service", '/tos'
  end
  
  def news
    add_crumb "news", '/news'
  end
  
end