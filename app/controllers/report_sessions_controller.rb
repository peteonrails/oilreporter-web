class ReportsController < ApplicationController
  before_filter :verify_api_key, :only => [:create]

  def create
    report_session = ReportSession.create

    if report_session.save
      render :json => { :id => report_session.id }, :status => :ok
    else
      render :json => report_session.errors, :status => :unprocessable_entity
    end
  end

end
