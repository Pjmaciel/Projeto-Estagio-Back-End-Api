# spec/models/answer_spec.rb
require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:formulary) { FactoryBot.create(:formulary) }
  let(:question) { FactoryBot.create(:question, formulary: formulary) }
  let(:visit) { FactoryBot.create(:visit) }

  it "is valid with valid attributes" do
    answer = Answer.new(content: "Resposta 1", formulary: formulary, question: question, visit: visit, answered_at: DateTime.now)
    expect(answer).to be_valid
  end

  it "is not valid without a question_id" do
    answer = Answer.new(content: "Resposta 1", formulary: formulary, visit: visit, answered_at: DateTime.now)
    expect(answer).to_not be_valid
    expect(answer.errors[:question_id]).to include("can't be blank")
  end

  it "is not valid without a formulary_id" do
    answer = Answer.new(content: "Resposta 1", question: question, visit: visit, answered_at: DateTime.now)
    expect(answer).to_not be_valid
    expect(answer.errors[:formulary_id]).to include("can't be blank")
  end
end
