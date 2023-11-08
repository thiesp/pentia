class V1::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!
  respond_to :json

  resource_description do
    short 'Sessions'
    formats ['json']
    api_version '1'
    
  end

  def_param_group :session do
    param :user, Hash, required: true do
      param :email, String, desc: "Email for login", required: true
      param :password, String, desc: "Password for login", required: true
    end
  end

  api :POST, 'v1/sessions', "Login to a new session"
  param_group :session
  error :unauthorized, I18n.t('devise.failure.invalid')
  returns code: :created, desc: "Success" do
    property :email, String
    property :name, String
    property :token, String, desc: "Authentication token"
  end
  example "params: {\"user\":{\"email\":\"user@email\",\"password\":\"123456\"}}
headers: {\"Api-Key\":\"api_key\"}
response: {\"email\":\"francis@cruickshank.test\",\"name\":\"Jospeh Wisoky\",
  \"token\":\"eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI4YzhiMzIwZS1hMTlkLTRlYjgtYjAwYS0wNjY3ODg0YjA4OGYiLCJzdWIiOiI3OCIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY5OTQzMTMyMSwiZXhwIjoxNjk5NDM0OTIxfQ._8Gl6cP1G0mLJRwOwaZqWxR_o_UvC20tOu8IqOHFo7M\"}"
  def create
    super
  end
end
