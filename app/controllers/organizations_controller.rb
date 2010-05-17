class OrganizationsController < ApplicationController
  def index
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      flash[:notice] = "Thank you!  We'll be getting in touch with you shortly."
    else
      flash[:error] = "There was a problem trying to save your information - please try again."
    end
    
    redirect_to(:controller => "home", :action => "localize")
  end
end
