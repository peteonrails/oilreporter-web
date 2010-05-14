class ReportsController < ApplicationController

  before_filter :verify_api_key, :only => [:create, :update]

  def create
    report = current_developer.reports.new(filtered_params)

    respond_to do |format|
      format.json {
        if report.save
          render :json => { :id => report.id }, :status => :ok
        else
          render :json => report.errors, :status => :unprocessable_entity
        end
      }
    end
  end

  def update
    report = current_developer.reports.find(filtered_params.delete(:id))

    unless report
      render :nothing => true, :status => :not_found
      return
    end

    if report.update_attributes(filtered_params)
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end

  def index
    respond_to do |format|
      format.json {
        return unless verify_api_key
        @reports = current_developer.reports.paginate(:page => params[:page], :order => 'created_at DESC')
        render :json => @reports.collect(&:hew), :layout => false
      }
      format.html {
        @reports = Report.paginate(:page => params[:page], :order => 'created_at DESC')
        render
      }
    end
  end

  def map
    @reports = Report.all
  end

end
