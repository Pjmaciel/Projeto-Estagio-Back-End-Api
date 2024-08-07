# spec/controllers/answers_controller_spec.rb
require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:formulary) { FactoryBot.create(:formulary) }
  let(:question) { FactoryBot.create(:question) }
  let(:visit) { FactoryBot.create(:visit) }
  let(:valid_attributes) { { content: "Sample Answer", formulary_id: formulary.id, question_id: question.id, visit_id: visit.id, answered_at: Time.now } }
  let(:invalid_attributes) { { content: nil, formulary_id: nil, question_id: nil, visit_id: nil, answered_at: nil } }
  let(:answer) { FactoryBot.create(:answer) }
  let(:user) { FactoryBot.create(:user) }
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
      get :show, params: { id: answer.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(answer.content)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new answer" do
        expect {
          post :create, params: { answer: valid_attributes }
        }.to change(Answer, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.body).to include("Sample Answer")
      end
    end

    context "with invalid attributes" do
      it "does not create a new answer" do
        expect {
          post :create, params: { answer: invalid_attributes }
        }.to_not change(Answer, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the requested answer" do
        patch :update, params: { id: answer.id, answer: { content: "Updated Answer" } }
        answer.reload
        expect(answer.content).to eq("Updated Answer")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      it "does not update the answer" do
        put :update, params: { id: answer.id, answer: invalid_attributes }
        answer.reload
        expect(answer.content).not_to eq(nil)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested answer" do
      answer_to_delete = FactoryBot.create(:answer, content: "Answer to delete")
      expect {
        delete :destroy, params: { id: answer_to_delete.id }
      }.to change(Answer, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
