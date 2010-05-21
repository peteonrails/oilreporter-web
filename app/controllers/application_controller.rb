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
    params.delete(:organization_id)
    return true unless params[:organization_pin]

    @organization = Organization.find_by_pin(params.delete(:organization_pin))
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
