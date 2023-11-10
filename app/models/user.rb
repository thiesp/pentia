class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :basket, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates_presence_of :name

  # disable all notifications
  def send_devise_notification(notification, *args)
  end

  def token
    scope ||= Devise::Mapping.find_scope!(self)
    token, payload = Warden::JWTAuth::UserEncoder.new.call(
      self, scope, nil
    )
    token
  end
end
