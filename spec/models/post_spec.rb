require 'rails_helper'

RSpec.describe Post, type: :model do
  # describe "Associations" do
  #   it { is_expected.to belong_to(:user) }
  # end
  

  let(:post) { 
    build(:user)
    build(:post)
  }
  it "is valid with a valid modle" do
    expect(post).to be_valid
  end

  it "is not valid with a valid modle" do
    post.content = ''
    expect(post).to_not be_valid
  end

end
