class Notifications < ActionMailer::Base
  def notify(name, email, comment, sent_at = Time.now)
    subject    "New message from #{name}"
    recipients 'photos@capturedbyashley.com'
    from       email
    sent_on    sent_at

    body       :comment => comment
  end

end