require 'rails_helper'

describe AccessToken do
  include ActiveSupport::Testing::TimeHelpers

  it { should belong_to :user }

  it { should validate_presence_of :user }

  describe "before_validation callback" do
    it "generates an access token" do
      user = FactoryGirl.build_stubbed(:user)
      access_token = AccessToken.create!(user: user)

      expect(access_token.access_token).to_not be_nil
    end

    it "sets an expires_at" do
      travel_to Time.zone.at(0) do
        user = FactoryGirl.build_stubbed(:user)
        access_token = AccessToken.create!(user: user)

        expect(access_token.expires_at).to eq 30.days.from_now
      end
    end
  end

  describe "#expires_in" do
    it "returns the number of seconds remaining until the token is expired" do
      travel_to Time.zone.at(0) do
        access_token = AccessToken.new(created_at: Time.zone.now,
                                       expires_at: 5.minutes.from_now)

        expect(access_token.expires_in).to eq 300
      end
    end

    it "returns 0 when token has expired" do
      travel_to Time.zone.at(0) do
        access_token = AccessToken.new(created_at: Time.zone.now,
                                       expires_at: 5.minutes.ago)

        expect(access_token.expires_in).to eq 0
      end
    end
  end
end
