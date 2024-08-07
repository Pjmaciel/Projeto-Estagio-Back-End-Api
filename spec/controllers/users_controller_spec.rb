# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_attributes) { { name: "Updated User", email: user.email, password: user.password, cpf: user.cpf } }
  let(:invalid_attributes) { { name: nil, email: nil, password: nil, cpf: nil } }
  let(:new_user_attributes) { { name: "Test User", email: "test@example.com", password: "password123", cpf: "42516054033" } }
  let(:valid_token) { JsonWebToken.encode(user_id: user.id) }

  before(:each) do
    FactoryBot.rewind_sequences
  end

  describe "GET #index" do
    context "with valid token" do
      it "returns a successful response" do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "without token" do
      it "returns unauthorized status" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET #show" do
    context "with valid token" do
      it "returns a successful response" do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(user.name)
      end
    end

    context "without token" do
      it "returns unauthorized status" do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new user and returns a JWT token" do
        expect {
          post :create, params: { user: new_user_attributes }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context "with invalid attributes" do
      it "does not create a new user" do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid token and valid attributes" do
      it "updates the requested user" do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        patch :update, params: { id: user.to_param, user: valid_attributes }
        user.reload
        expect(user.name).to eq("Updated User")
      end
    end

    context "with valid token and invalid attributes" do
      it "does not update the user" do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        put :update, params: { id: user.id, user: invalid_attributes }
        user.reload
        expect(user.name).not_to eq("")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "without token" do
      it "returns unauthorized status" do
        put :update, params: { id: user.id, user: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid token" do
      it "destroys the requested user" do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        user_to_delete = FactoryBot.create(:user, email: "delete@example.com", cpf: "42516054033") # Use um CPF válido diferente
        expect {
          delete :destroy, params: { id: user_to_delete.id }
        }.to change(User, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "without token" do
      it "returns unauthorized status" do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
