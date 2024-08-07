# spec/controllers/auth_controller_spec.rb
require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  let(:user) { FactoryBot.create(:user, password: 'password123') }

  describe "POST #login" do
    context "with valid credentials" do
      it "returns a JWT token" do
        post :login, params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized status" do
        post :login, params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
