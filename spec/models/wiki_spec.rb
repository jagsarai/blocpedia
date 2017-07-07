require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user){create (:user)}
  let(:wiki){create (:wiki), user: user}

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_length_of(:title).is_at_least(5)}
  it { is_expected.to validate_length_of(:body).is_at_least(20) }
  it { is_expected.to validate_presence_of(:user) }


  describe "attributes" do
    it "should have a title, body, private and user" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: user)
    end
  end
end
