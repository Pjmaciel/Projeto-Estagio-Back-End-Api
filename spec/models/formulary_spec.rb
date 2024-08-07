require 'rails_helper'

RSpec.describe Formulary, type: :model do
  it "is valid with a unique nome" do
    formulary = Formulary.new(nome: "Formulary 1")
    expect(formulary).to be_valid
  end

  it "is not valid without a nome" do
    formulary = Formulary.new(nome: nil)
    expect(formulary).to_not be_valid
    expect(formulary.errors[:nome]).to include("can't be blank")
  end

  it "is not valid with a duplicate nome" do
    Formulary.create!(nome: "Formulary 1")
    formulary = Formulary.new(nome: "Formulary 1")
    expect(formulary).to_not be_valid
    expect(formulary.errors[:nome]).to include("has already been taken")
  end
end
