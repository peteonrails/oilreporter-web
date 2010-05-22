class ApplicationController < ActionController::Base
  add_crumb "home", '/'

  helper :all

  # protect_from_forgery

  protected

  def filtered_params
    @filtered_params ||= params.symbolize_keys.reject { |k, v| [:action, :controller, :_method].include?(k) }
  end

  def current_developer
    @developer
  end

  def current_organization
    @organization
  end

  def extract_organization_pin
    # Supporting organization_id for the older version of the mobile app

    begin
      if params[:organization_id] && params[:organization_pin].nil?
        @organization = Organization.find_by_pin(params.delete(:organization_id))
      else
        @organization = Organization.find_by_pin(params.delete(:organization_pin))
      end
    rescue Exception => e
      logger.error("#{e.class}: #{e.message}")
      logger.error(e.backtrace.join("\n"))
    end

    return true if pin.blank?
    @organization = Organization.find_by_pin(pin)

    unless !!@organization
      render :json => { :error => 'Invalid organization pin' }, :status => :unprocessable_entity
      return false
    end
    return true
  end

  def verify_api_key
    @developer = Developer.find_by_api_key(params.delete(:api_key))

    unless !!@developer
      render :json => { :error => 'Invalid API key' }, :status => :unprocessable_entity
      return false
    end
    return true
  end

end
