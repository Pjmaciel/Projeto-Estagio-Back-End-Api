# spec/factories/questions.rb
FactoryBot.define do
  factory :question do
    name { "Pergunta 1" }
    formulary
    question_type { "Texto" }
  end
end
