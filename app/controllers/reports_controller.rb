class ReportsController < ApplicationController
  
  def create
    report = Report.new(params[:report])

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
    report = Report.find(params[:id])

    unless report
      render :nothing => true, :status => :not_found
      return
    end

    if report.update_attributes(params[:report])
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end

  def index
    @reports = Report.paginate(:page => params[:page], :order => 'created_at DESC')
    respond_to do |format|
      format.json {
        render :json => @reports.collect(&:hew), :layout => false
      }
      format.html {
        render
      }
    end
  end

  def map
    @reports = Report.all
  end

end
