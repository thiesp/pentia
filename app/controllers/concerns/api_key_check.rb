require "active_support/concern"

module ApiKeyCheck
  extend ActiveSupport::Concern

  private
  def require_api_key
    unless ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.api_key, request.headers['Api-Key'].to_s)
      render json: {error: I18n.t("api_key.invalid")}, status: 401
    end
  end

  included do
    before_action :require_api_key
  end
end