class Notifier < ActionMailer::Base
  include ActionController::UrlWriter
  helper :application

  default_url_options[:host] = HOST

  def api_key(developer)
    subject       "Your API Key"
    from          "Oil Reporter <noreply@#{HOST}>"
    recipients    developer.email
    sent_on       Time.now
    body          :api_key => developer.api_key
  end
end
