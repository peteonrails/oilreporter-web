class ReportsController < ApplicationController

  before_filter :verify_api_key, :only => [:create, :update]
  before_filter :extract_organization_pin, :only => [:create, :update]

  def show
    state = State.find_by_name(params[:state].titleize)
    return not_found unless state

    @report = state.reports.find_by_slug(params[:id])
    return not_found unless @report
  end

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
    
    unless filtered_params[:meta].blank?
      meta_params = filtered_params.delete(:meta)
      ReportMeta.create_from_params(report, meta_params)
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
      @reports = Report.within_oil_spill.paginate(:page => params[:page], :order => 'created_at DESC')

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
    @reports = Report.within_oil_spill
  end

end
