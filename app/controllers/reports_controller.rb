class ReportsController < ApplicationController

  before_filter :verify_api_key, :only => [:create, :update]
  before_filter :extract_organization_pin, :only => [:create, :update]

  def create
    report = current_developer.reports.new(filtered_params)

    if report.save
      report.update_attribute(:organization, current_organization) if current_organization
      render :json => { :id => report.id }, :status => :ok
    else
      render :json => report.errors, :status => :unprocessable_entity
    end
  end

  def update
    report = current_developer.reports.find(filtered_params.delete(:id))

    unless report
      render :nothing => true, :status => :not_found
      return
    end

    if report.update_attributes(filtered_params)
      report.update_attribute(:organization, current_organization) if current_organization
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end

  def index
    add_crumb "reports", '/reports'
    respond_to do |format|
      @reports = Report.paginate(:page => params[:page], :order => 'created_at DESC')

      format.json {
        return unless verify_api_key
        render :json => @reports.collect(&:hew), :layout => false
      }
      format.html {
        render
      }
      format.rss { 
        render :layout => false
      }
      format.xml { 
        render :xml => @reports.to_xml
      }
    end
  end

  def map
    add_crumb "map", '/map'
    @reports = Report.all
  end

end
