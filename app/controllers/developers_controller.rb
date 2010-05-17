require 'base64'

class DevelopersController < ApplicationController

  def new
    add_crumb "sign up", '/signup'
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(params[:developer])

    if @developer.save
      Notifier.deliver_api_key(@developer)
      redirect_to :action => 'show', :id => Base64.encode64(@developer.email).strip
    else
      flash[:error] = "There was a problem trying to create your API key"
      render :new
    end
  end

  def show
    add_crumb "sign up success", ''
    email = Base64.decode64(params[:id])
    @developer = Developer.find_by_email(email)

    if !@developer
      render :nothing => true, :status => :not_found
      return
    else
      flash[:success] = "#{@developer.api_key}"
    end
  end

end
