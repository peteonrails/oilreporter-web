class HomeController < ApplicationController
  
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
  
end