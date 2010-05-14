require 'base64'

class DevelopersController < ApplicationController

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(params[:developer])

    if @developer.save
      redirect_to :action => 'show', :id => Base64.encode64(@developer.email).strip
    else
      render :new
    end
  end

  def show
    email = Base64.decode64(params[:id])
    @developer = Developer.find_by_email(email)

    if !@developer
      render :nothing => true, :status => :not_found
      return
    end
  end

end
