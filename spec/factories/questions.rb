FactoryBot.define do
  factory :question do
    nome { "Pergunta 1" }
    formulary
    question_type { 'Texto'}
  end
end