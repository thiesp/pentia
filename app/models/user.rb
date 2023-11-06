class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  validates_presence_of :name

  # disable all notifications
  def send_devise_notification(notification, *args)
  end
end
