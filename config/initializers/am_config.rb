ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "capturedbyashley.com",
  :authentication => :plain,
  :user_name => "photos@capturedbyashley.com",
  :password => "newlyweds0"
}