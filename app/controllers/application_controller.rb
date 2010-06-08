class ApplicationController < ActionController::Base
  add_crumb "home", '/'
  
  helper :all
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  protect_from_forgery
  
  private

    def not_found(options = {})
      options = { :file => File.join(File.dirname(__FILE__), '../../public/404.html'), :status => :not_found }.merge(options)
      render options
      false
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "Please sign in to access admin area."
        redirect_to new_user_session_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def include_syntax_highlighter
      @include_syntax_highlighter = true
    end
    
  protected

    def filtered_params
      @filtered_params ||= params.symbolize_keys.reject { |k, v| [:action, :controller, :_method, :organization_pin, :organization_id].include?(k) }
    end

    def current_developer
      @developer
    end

    def current_organization
      @organization
    end

    def extract_organization_pin

      # Supporting organization_id for the older version of the mobile app
      if params[:organization_pin]
        pin = params.delete(:organization_pin)
        params.delete(:organization_id)
      elsif params[:organization_id]
        pin = params.delete(:organization_id)
        params.delete(:organization_pin)
      else
        return true
      end

      return true if pin.blank?
    
      begin
        @organization = Organization.find_by_pin(pin)
      rescue Exception => e
        logger.error("#{e.class}: #{e.message}")
        logger.error(e.backtrace.join("\n"))
        return true
      end
    
      unless !!@organization
        # Currently not returning an error if the organization is not found
        # render :json => { :error => 'Invalid organization pin' }, :status => :unprocessable_entity
        # return false
        return true
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
