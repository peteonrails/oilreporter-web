class ReportSessionsController < ApplicationController
  before_filter :verify_api_key, :only => [:create, :update, :show]
  skip_before_filter :verify_authenticity_token

  def show
    report_session = ReportSession.find(params.delete(:id))
    return not_found unless report_session
    
    render :json => report_session.to_json, :status => :ok
  end
  
  def create
    report_session = ReportSession.create
    if report_session.save
      render :json => { :id => report_session.id }, :status => :ok
    else
      render :json => report_session.errors, :status => :unprocessable_entity
    end
  end
  
  def update
    report_session = ReportSession.find(params.delete(:id))
    
    unless params[:meta].blank?
      meta_params = params.delete(:meta)
      SessionMeta.create_from_params(report_session, meta_params)
    end
    
    render :nothing => true, :status => :ok
  end

end
