class User < ActiveRecord::Base
  has_many :access_tokens, dependent: :destroy

  validates :email, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :username, presence: true

  def self.find_or_create_from_oauth(oauth)
    attributes = {
      email: oauth.email,
      provider: 'github',
      uid: oauth.id.to_s,
      username: oauth.login,
    }

    where(attributes.slice(:uid, :provider)).first_or_initialize.tap do |u|
      u.email = attributes[:email]
      u.username = attributes[:username]
      u.save
    end
  end
end
