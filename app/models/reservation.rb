class Reservation < ApplicationRecord
  belongs_to :guest
  belongs_to :table
  after_create_commit :send_create_notification_mailer
  after_update :send_update_notification_mailer

  def send_create_notification_mailer
    NotificationMailService.send_confirmation_mail(self)
  end

  def send_update_notification_mailer
    NotificationMailService.send_update_confiramtion_mail(self)
  end

  def restaurant
    table.restaurant
  end
end
