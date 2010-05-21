class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.paginate(:page => params[:page])
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      flash[:info] = "Thank you! We'll be getting in touch with you shortly."
      Notifier.deliver_organization_pin(@organization)
      redirect_to :controller => 'home', :action => 'setup'
    else
      flash[:error] = "There was a problem trying to save your information. Please complete all fields."
      render :new
    end
  end

end
