class V1::SessionsController < Devise::SessionsController
  respond_to :json

  resource_description do
    short 'Sessions'
    formats ['json']
    api_version '1'
    
  end

  def_param_group :session do
    param :user, Hash, required: true do
      param :email, /\A[^@\s]+@[^@\s]+\z/, desc: "Email for login", required: true
      param :password, String, desc: "Password for login", required: true
    end
  end

  api :POST, 'v1/sessions', "Login to a new session"
  param_group :session
  error :unauthorized, I18n.t('devise.failure.invalid')
  returns code: :created, desc: "Success" do
    property :id, Integer
    property :email, String
    property :name, String
    property :create_at, Time
    property :updated_at, Time
    property :jti, String, desc: "Authentication token"
  end
  example "params: {\"user\":{\"email\":\"user@email\",\"password\":\"123456\"}}
headers: {\"Api-Key\":\"api_key\"}"
  example "response: {\"id\":18,\"email\":\"francis@cruickshank.test\",\"name\":\"Jospeh Wisoky\",
  \"created_at\":\"2023-11-06T08:47:25.619Z\",\"updated_at\":\"2023-11-06T08:47:25.619Z\",\"jti\":\"8f299cb2-1418-495e-bbf0-e8386d0db044\"}"
  def create
    super
  end
end
