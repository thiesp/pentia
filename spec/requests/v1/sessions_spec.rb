require 'rails_helper'

RSpec.describe "V1::Sessions", type: :request do
  context "with user" do
    let(:user) {FactoryBot.build(:user)}
    before(:each) do 
      user.save!
    end
 
    describe "POST /v1/sessions" do
      it "create a new session" do
        post v1_sessions_path+".json", params: {
          user: {
            email: user.email,
            password: "123456" 
          }
        }, headers: {'Api-Key' => Rails.application.credentials.api_key }
        expect(response).to have_http_status(201)
      end

      it "provides a auth token" do
        post v1_sessions_path+".json", params: {
          user: {
            email: user.email,
            password: "123456" 
          }
        }, headers: {'Api-Key' => Rails.application.credentials.api_key }
        expect(JSON.parse(response.body)['jti']).to_not be_empty
      end

      it "rejects wrong credentials" do
        post v1_sessions_path+".json", params: {
          user: {
            email: user.email,
            password: "wrong password"
          }
        }, headers: {'Api-Key' => Rails.application.credentials.api_key }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq I18n.t('devise.failure.invalid')
      end

      it "rejects wrong api key" do
        post v1_sessions_path+".json", params: {
          user: {
            email: user.email,
            password: "123456"
          }
        }, headers: {'Api-Key' => "Wrong key" }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq I18n.t('api_key.invalid')
      end
    end
  end
end
