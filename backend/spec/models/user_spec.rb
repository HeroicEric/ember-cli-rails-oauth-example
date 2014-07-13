require 'rails_helper'

describe User do
  it { should have_many(:access_tokens).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :username }

  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }

  describe "#access_token" do
    it "returns the first active access token" do
      user = FactoryGirl.build_stubbed(:user)
      active_access_token = FactoryGirl.create(:access_token, :active, user: user)

      expect(user.access_token).to eq active_access_token
    end

    it "does not return inactive access tokens" do
      user = FactoryGirl.build_stubbed(:user)
      FactoryGirl.create(:access_token, :inactive, user: user)

      expect(user.access_token).to eq nil
    end
  end
end
