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
  
end