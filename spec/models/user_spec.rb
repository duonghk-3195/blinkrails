require 'rails_helper'

RSpec.describe User, type: :model do
  # describe "Associations" do
  #   it { is_expected.to has_many(:posts) }
  # end

  let(:user) { 
    build(:user)
  }
  it "is valid with a valid modle" do
    expect(user).to be_valid
  end

  it "is not valid without a email" do
    user.email = ''
    expect(user).not_to be_valid
  end

  it "is not valid with email longer than 255 character" do
    user.email = "exam#{Faker::Lorem.characters(number: 250)}ple.email@gmail.com"
    expect(user).not_to be_valid
  end

  it "is not valid with incorrect email format" do
    user.email = Faker::Lorem.characters(number: 30)
    expect(user).not_to be_valid
  end

  it "it not valid without a password" do  # case này failse do đang sử dụng has_secure_password
    user.password = ''
    expect(user).not_to be_valid
  end

  it "it not valid with password shoter than 6 character" do
    user.password = Faker::Lorem.characters(number: 5)
    expect(user).not_to be_valid
  end

  it "it not valid without a name" do
    user.name = ''
    expect(user).not_to be_valid
  end

  it "it not valid with name longer than 50 character" do
    user.name = Faker::Lorem.characters(number: 51)
    expect(user).not_to be_valid
  end

  it "it not valid with name shoter than 5 character" do
    user.name = Faker::Lorem.characters(number: 4)
    expect(user).not_to be_valid
  end
end
