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

end
