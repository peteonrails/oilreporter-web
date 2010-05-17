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

  def verify_api_key
    @developer = Developer.find_by_api_key(params.delete(:api_key))

    unless !!@developer
      render :json => { :error => 'Invalid API key' }, :status => :unprocessable_entity
      return false
    end
    return true
  end

end
