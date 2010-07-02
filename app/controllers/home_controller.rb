class HomeController < ApplicationController

  ENABLE_FEATURED_POSTS = true;

  def index
    canonical_url root_path
  end
  
  def sitemap
    sitemap = Sitemap.instance.create!
    render :xml => sitemap
  end
  
  def setup
    add_crumb "setup", '/setup'
    canonical_url '/setup'
  end
  
  def api
    add_crumb "api", '/api'
    canonical_url '/api'
  end
  
  def tools
    add_crumb "tools", '/tools'
    canonical_url '/tools'
  end
  
  def about
    add_crumb "about", '/about'
    canonical_url '/about'
  end
  
  def privacy
    add_crumb "privacy", '/privacy'
    canonical_url '/privacy'
  end
  
  def data_sources
    add_crumb "data sources", '/data-sources'
    canonical_url '/data-sources'
  end
  
  def tos
    add_crumb "terms of service", '/tos'
    canonical_url '/tos'
  end
  
  def news
    add_crumb "news", '/news'
    canonical_url '/news'
  end
  
end