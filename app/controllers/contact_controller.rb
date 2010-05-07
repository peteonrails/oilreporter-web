class ContactController < ApplicationController
  
  def notify
    Notifications.deliver_notify(params[:name], params[:email], params[:message])
    flash[:notice] = "Thanks for contacting us!"
  end
  
end
