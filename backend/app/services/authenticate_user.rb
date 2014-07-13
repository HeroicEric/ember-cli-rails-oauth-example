class AuthenticateUser
  attr_accessor :user

  def initialize(authorization_code)
    @authorization_code = authorization_code
  end

  def perform
    token = app_client.exchange_code_for_token(@authorization_code)
    user_data = user_client(token).user

    if user_data.email.blank?
      user_data.email = user_client.emails.find { |e| e.primary }.email
    end

     self.user = User.find_or_create_from_oauth(user_data)
  end

  def success?
    user.present? && user.persisted?
  end

  private

  def app_client
    @app_client ||= Octokit::Client.new(
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
  end

  def user_client(token)
    Octokit::Client.new(access_token: token.access_token)
  end
end
