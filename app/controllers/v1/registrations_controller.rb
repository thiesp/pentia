class V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
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
  returns code: :ok, desc: "Success" do
    property :email, String
    property :name, String
    property :token, String, desc: "Authentication token"
  end
  example "params: {\"user\":{\"name\":\"Jospeh Wisoky\",\"email\":\"user@email\",\"password\":\"123456\"}}
headers: {\"Api-Key\":\"api_key\"}
response: {\"email\":\"francis@cruickshank.test\",\"name\":\"Jospeh Wisoky\",
  \"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI4YzhiMzIwZS1hMTlkLTRlYjgtYjAwYS0wNjY3ODg0YjA4OGYiLCJzdWIiOiI3OCIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY5OTQzMTMyMSwiZXhwIjoxNjk5NDM0OTIxfQ._8Gl6cP1G0mLJRwOwaZqWxR_o_UvC20tOu8IqOHFo7M\"}"
  def create
    super
  end

  private
  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end
end
