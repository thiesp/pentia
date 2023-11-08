require 'rails_helper'

RSpec.describe "V1::Registrations", type: :request do
  describe "POST /v1/registrations" do
    it "create a new user" do
      expect {
        post v1_registrations_path+".json", params: {
          user: {
            name: "Test User",
            email: "test@pentia.dk",
            password: "123456"
          } 
        }, headers: {'Api-Key' => Rails.application.credentials.api_key }
      }.to change{ User.count }.by(1)
      expect(response).to have_http_status(200)
    end

    it "provides a auth token" do
      post v1_registrations_path+".json", params: {
        user: {
          name: "Test User",
          email: "test@pentia.dk",
          password: "123456" 
        }
      }, headers: {'Api-Key' => Rails.application.credentials.api_key }
      expect(JSON.parse(response.body)['token']).to_not be_empty
    end

    it "rejects wrong email" do
      post v1_registrations_path+".json", params: {
        user: {
          name: "Test User",
          email: "not a email",
          password: "123456"
        }
      }, headers: {'Api-Key' => Rails.application.credentials.api_key }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq ({ "email" => [I18n.t('errors.messages.invalid')]})
    end

    it "rejects too short passwords" do
      post v1_registrations_path+".json", params: {
        user: {
          name: "Test User",
          email: "test@pentia.dk",
          password: "123"
        }
      }, headers: {'Api-Key' => Rails.application.credentials.api_key }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq ({"password" => [I18n.t('errors.messages.too_short', count: 6)]})
    end

    context "with user" do
      let(:user) {FactoryBot.build(:user)}
      before(:each) do 
        user.save!
      end
      it "rejects existing users" do
        post v1_registrations_path+".json", params: {
        user: {
          name: user.name,
          email: user.email,
          password: "123456"
        }
      }, headers: {'Api-Key' => Rails.application.credentials.api_key }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to eq ({"email" => [I18n.t('errors.messages.taken')]})
      end
    end
  end
end
