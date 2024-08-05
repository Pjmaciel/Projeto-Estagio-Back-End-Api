class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cpf, presence: true, uniqueness: true, cpf: true
  validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: 'must include both letters and numbers' }
end
