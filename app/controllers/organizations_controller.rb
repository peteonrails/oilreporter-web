class OrganizationsController < ApplicationController
  def index
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      flash[:info] = "Thank you! We'll be getting in touch with you shortly."
    else
      flash[:error] = "There was a problem trying to save your information. Please complete all fields."
    end
    redirect_to(:controller => "home", :action => "setup")
  end
end
