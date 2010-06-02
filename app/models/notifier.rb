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

  def organization_pin(organization)
    subject       "Your organization pin"
    from          "Oil Reporter <noreply@#{HOST}>"
    recipients    organization.email
    sent_on       Time.now
    body          :pin => organization.pin
  end

  def organization_signup(organization)
    subject    "A new organization signed up"
    from       "Oil Reporter <noreply@#{HOST}>"
    recipients Oilreporter.config.organization_signup_recipients
    sent_on    Time.now
    body       :organization => organization
  end

end
