# spec/models/question_spec.rb
require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:formulary) { FactoryBot.create(:formulary) }
  let(:other_formulary) { FactoryBot.create(:formulary, nome: "Formulary 2") }

  it "is valid with valid attributes" do
    question = Question.new(name: "Pergunta 1", formulary: formulary, question_type: "Texto")
    expect(question).to be_valid
  end

  it "is not valid without a name" do
    question = Question.new(name: nil, formulary: formulary, question_type: "Texto")
    expect(question).to_not be_valid
    expect(question.errors[:name]).to include("can't be blank")
  end

  it "is not valid with a duplicate name within the same formulary" do
    Question.create!(name: "Pergunta 1", formulary: formulary, question_type: "Texto")
    question = Question.new(name: "Pergunta 1", formulary: formulary, question_type: "Foto")
    expect(question).to_not be_valid
    expect(question.errors[:name]).to include("has already been taken")
  end

  it "is valid with a duplicate name in a different formulary" do
    Question.create!(name: "Pergunta 1", formulary: formulary, question_type: "Texto")
    question = Question.new(name: "Pergunta 1", formulary: other_formulary, question_type: "Foto")
    expect(question).to be_valid
  end
end
