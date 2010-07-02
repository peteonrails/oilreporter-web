class OrganizationsController < ApplicationController

  before_filter :verify_api_key, :only => [:show]

  def index
    # Per Heather's request, no longer showing signed-up organizations
    redirect_to :controller => 'home', :action => 'setup' and return

    add_crumb "organizations", '/organizations'
    canonical_url '/organizations'
    @organizations = Organization.paginate(:page => params[:page])
  end

  def create
    add_crumb "new", '/organizations/new'
    canonical_url '/organizations/new'
    @organization = Organization.new(params[:organization])

    if @organization.valid? &
       (RAILS_ENV == 'production' ? verify_recaptcha(:model => @organization, :message => 'Captcha is invalid') : true)
      @organization.save
      flash.now[:info] = "Thank you! We'll be getting in touch with you shortly. Your PIN is #{@organization.pin}"
      Notifier.deliver_organization_pin(@organization)
      Notifier.deliver_organization_signup(@organization)
      redirect_to :controller => 'home', :action => 'setup'
    else
      flash.now[:error] = "There was a problem trying to save your information. Please complete all fields."
      render :new
    end
  end

  def show
    organization = Organization.find_by_pin(params[:id])

    if organization
      reports = organization.reports.paginate(:page => params[:page], :order => 'created_at DESC')
      render :json => reports.collect(&:hew), :layout => false, :status => :ok
    else
      render :json => { :error => 'Invalid organization pin' }, :status => :not_found, :layout => false
    end
  end

end
