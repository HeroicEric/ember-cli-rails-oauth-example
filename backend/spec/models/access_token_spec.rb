require 'rails_helper'

describe AccessToken do
  include ActiveSupport::Testing::TimeHelpers

  it { should belong_to :user }

  it { should validate_presence_of :user }

  describe ".active" do
    it "returns access tokens that have not expired" do
      future_date = Time.zone.now + 1.day
      access_token = FactoryGirl.create(:access_token, expires_at: future_date)

      expect(AccessToken.active).to include access_token
    end

    it "does not return access tokens that have expired" do
      past_date = Time.zone.now - 1.day
      access_token = FactoryGirl.create(:access_token, expires_at: past_date)

      expect(AccessToken.active).to_not include access_token
    end
  end

  describe ".from_request" do
    it "finds access token from request authorization" do
      request = double(authorization: "Bearer ABC")
      expect(AccessToken).to receive(:find_by).with(access_token: 'ABC')
      AccessToken.from_request(request)
    end

    it "fails gracefully when request has no authorization" do
      request = double(authorization: nil)
      expect { AccessToken.from_request(request) }.to_not raise_error
    end
  end

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

    it "uses provided expires_at if given" do
      travel_to Time.zone.at(0) do
        user = FactoryGirl.build_stubbed(:user)
        expires_at = 10.days.from_now
        access_token = AccessToken.create!(user: user, expires_at: expires_at)

        expect(access_token.expires_at).to eq expires_at
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
