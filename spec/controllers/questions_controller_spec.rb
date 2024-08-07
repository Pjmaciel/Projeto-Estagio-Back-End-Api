# spec/controllers/questions_controller_spec.rb
require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:formulary) { FactoryBot.create(:formulary) }
  let(:valid_attributes) { { name: "Sample Question", formulary_id: formulary.id, question_type: "text" } }
  let(:invalid_attributes) { { name: nil, formulary_id: nil, question_type: nil } }
  let(:question) { FactoryBot.create(:question, formulary: formulary) }
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
      get :show, params: { id: question.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(question.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new question" do
        expect {
          post :create, params: { question: valid_attributes }
        }.to change(Question, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.body).to include(valid_attributes[:name])
      end
    end

    context "with invalid attributes" do
      it "does not create a new question" do
        expect {
          post :create, params: { question: invalid_attributes }
        }.to_not change(Question, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the requested question" do
        patch :update, params: { id: question.id, question: valid_attributes }
        question.reload
        expect(question.name).to eq("Sample Question")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      it "does not update the question" do
        put :update, params: { id: question.id, question: invalid_attributes }
        question.reload
        expect(question.name).not_to eq(nil)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested question" do
      question_to_delete = FactoryBot.create(:question, formulary: formulary)
      expect {
        delete :destroy, params: { id: question_to_delete.id }
      }.to change(Question, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
