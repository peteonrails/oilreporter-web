class HomeController < ApplicationController
  
  def setup
    add_crumb "setup", '/setup'
  end
  
  def api
    add_crumb "api", '/api'
  end
  
end