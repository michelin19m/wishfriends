class NotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id, message)
    user = User.find(user_id)
    # Code to send notification (e.g., email, push notification)
    # This is an example using ActionMailer (assuming you have a UserMailer set up)
    UserMailer.notification_email(user, message).deliver_now
  end
end
