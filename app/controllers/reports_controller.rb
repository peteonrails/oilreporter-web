class ReportsController < ApplicationController

  before_filter :verify_api_key, :only => [:create, :update]
  before_filter :extract_organization_pin, :only => [:create, :update]

  def show
    add_crumb "reports", '/reports'
    state = State.find_by_slug(params[:state])
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
      format.json {
        return unless verify_api_key
        @reports = paginated_reports
        render :json => @reports.collect(&:hew), :layout => false
      }
      format.html {
        @reports = paginated_reports
        render
      }
      format.rss {
        @reports = paginated_reports
        render :layout => false
      }
      format.xml { 
        @reports = paginated_reports
        render :xml => @reports.to_xml
      }
      format.kml {
        @reports = Report.within_oil_spill
        render :layout => false
      }
    end
  end

  def map
    add_crumb "map", '/map'
    @reports = Report.within_oil_spill
  end

  private

  def paginated_reports
    if params[:report_session_id]
      report_session = ReportSession.find(params[:report_session_id])
      @reports = report_session.reports.within_oil_spill
    end

    @reports = Report.within_oil_spill if @reports.nil?
    @reports.paginate(:page => params[:page], :order => 'created_at DESC')
  end

end
