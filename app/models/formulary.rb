class Formulary < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
end
