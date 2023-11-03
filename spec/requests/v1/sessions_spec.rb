require 'rails_helper'

RSpec.describe "V1::Sessions", type: :request do
  context "with user" do
    let(:user) {FactoryBot.build(:user)}
    before(:each) do 
      user.save!
    end
 
    describe "POST /v1/sessions" do
      it "create a new session" do
        post user_session_path+".json", params: {
          user: {
            email: user.email,
            password: "123456" 
          }
        }, headers: {'Api-Key' => Rails.application.credentials.api_key }
        expect(response).to have_http_status(201)
      end

      it "provides a auth token" do
        post user_session_path+".json", params: {
          user: {
            email: user.email,
            password: "123456" 
          }
        }, headers: {'Api-Key' => Rails.application.credentials.api_key }
        expect(JSON.parse(response.body)['jti']).to_not be_empty
      end
    end
  end
end
