require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with a duplicate email" do
    FactoryBot.create(:user, email: "john.doe@example.com")
    user = FactoryBot.build(:user, email: "john.doe@example.com")
    expect(user).to_not be_valid
  end

  it "is not valid with an invalid email" do
    user = FactoryBot.build(:user, email: "invalid_email")
    expect(user).to_not be_valid
  end

  it "is not valid without a CPF" do
    user = FactoryBot.build(:user, cpf: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with a duplicate CPF" do
    FactoryBot.create(:user, cpf: "587.330.870-59")
    user = FactoryBot.build(:user, cpf: "587.330.870-59")
    expect(user).to_not be_valid
  end

  it "is not valid with an invalid CPF" do
    user = FactoryBot.build(:user, cpf: "123.456.789-00")
    expect(user).to_not be_valid
  end

  it "is not valid with a short password" do
    user = FactoryBot.build(:user, password: "short", password_confirmation: "short")
    expect(user).to_not be_valid
  end

  it "is not valid with a password that does not contain numbers" do
    user = FactoryBot.build(:user, password: "password", password_confirmation: "password")
    expect(user).to_not be_valid
  end

  it "is not valid with a password that does not contain letters" do
    user = FactoryBot.build(:user, password: "123456", password_confirmation: "123456")
    expect(user).to_not be_valid
  end
end
