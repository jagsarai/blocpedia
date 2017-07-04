require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_least(3) }

  describe "attributes" do

    it "should have name and email attributes" do
      expect(user).to have_attributes(username: user.username, email: user.email)
    end

    it "should have a password" do
      expect(user).to have_attributes(password: user.password)
    end

    it "should have unconfirmed email " do
      expect(user.confirm).to be_truthy
    end
  end

  describe "invalid username" do
    let(:user_with_invalid_username) { build(:user, username: "") }
    let(:user_with_invalid_email) { build(:user, email: "") }

    it "should be an invalid user due to blank username" do
      expect(user_with_invalid_username).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

  end

  describe ".avatar_url" do
  let(:known_user) { create(:user, email:"blochead@bloc.io") }

    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end

  end
end
