class V1::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix # Workaround for https://github.com/heartcombo/devise/issues/5473#issuecomment-1078475813

  respond_to :json

  resource_description do
    short 'Registrations'
    formats ['json']
    api_version '1'
    
  end

  def_param_group :user do
    param :user, Hash do
      param :name, String, desc: "First and last name", required: true
      param :email, String, desc: "Email for login", required: true
      param :password, String, desc: "Password for login", required: true
    end
  end

  api :POST, 'v1/registrations', "Create a new user"
  param_group :user
  error :unprocessable_entity, "Invalid user"
  returns code: :created, desc: "Success" do
    property :id, Integer
    property :email, String
    property :name, String
    property :create_at, Time
    property :updated_at, Time
    property :jti, String, desc: "Authentication token"
  end
  example "params: {\"user\":{\"name\":\"Jospeh Wisoky\",\"email\":\"user@email\",\"password\":\"123456\"}}
headers: {\"Api-Key\":\"api_key\"}
response: {\"id\":18,\"email\":\"francis@cruickshank.test\",\"name\":\"Jospeh Wisoky\",
  \"created_at\":\"2023-11-06T08:47:25.619Z\",\"updated_at\":\"2023-11-06T08:47:25.619Z\",\"jti\":\"8f299cb2-1418-495e-bbf0-e8386d0db044\"}"
  def create
    super
  end

  private
  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end
end
