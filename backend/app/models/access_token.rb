class AccessToken < ActiveRecord::Base
  belongs_to :user

  validates :access_token, presence: true
  validates :expires_at, presence: true
  validates :user, presence: true

  before_validation :set_access_token, :set_expires_at, on: :create

  def expires_in
    seconds_remaining = (expires_at - created_at).round
    seconds_remaining > 0 ? seconds_remaining : 0
  end

  def self.active
    where('expires_at >= ?', Time.zone.now)
  end

  def self.from_request(request)
    return unless request.authorization

    bearer_token = request.authorization.gsub(/\ABearer /, '')
    find_by(access_token: bearer_token)
  end

  private
  def set_access_token
    return if access_token.present?

    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: self.access_token)
  end

  def set_expires_at
    return if expires_at.present?

    self.expires_at = Time.now + 30.days
  end
end
