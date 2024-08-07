require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  let(:user) { FactoryBot.create(:user, password: 'password123') }

  describe "POST #login" do
    context "with valid credentials" do
      it "returns a JWT token" do
        post :login, params: { auth: { email: user.email, password: 'password123' } }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized status" do
        post :login, params: { auth: { email: user.email, password: 'wrongpassword' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #logout" do
    it "returns a successful logout message" do
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"
      post :logout
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq('message' => 'Logged out')
    end
  end
end
