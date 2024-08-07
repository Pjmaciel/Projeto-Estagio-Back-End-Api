# spec/controllers/formularies_controller_spec.rb
require 'rails_helper'

RSpec.describe FormulariesController, type: :controller do
  let(:valid_attributes) { { nome: "Sample Formulary" } }
  let(:invalid_attributes) { { nome: nil } }
  let(:formulary) { FactoryBot.create(:formulary) }
  let(:user) { FactoryBot.create(:user) }  # Defina a variável user
  let(:valid_token) { JsonWebToken.encode(user_id: user.id) }

  before(:each) do
    FactoryBot.rewind_sequences
    request.headers['Authorization'] = "Bearer #{valid_token}"
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: formulary.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(formulary.nome)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new formulary" do
        expect {
          post :create, params: { formulary: valid_attributes }
        }.to change(Formulary, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.body).to include("Sample Formulary")
      end
    end

    context "with invalid attributes" do
      it "does not create a new formulary" do
        expect {
          post :create, params: { formulary: invalid_attributes }
        }.to_not change(Formulary, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the requested formulary" do
        patch :update, params: { id: formulary.id, formulary: { nome: "Updated Formulary" } }
        formulary.reload
        expect(formulary.nome).to eq("Updated Formulary")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      it "does not update the formulary" do
        put :update, params: { id: formulary.id, formulary: invalid_attributes }
        formulary.reload
        expect(formulary.nome).not_to eq(nil)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested formulary" do
      formulary_to_delete = FactoryBot.create(:formulary, nome: "Formulary to delete")
      expect {
        delete :destroy, params: { id: formulary_to_delete.id }
      }.to change(Formulary, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
