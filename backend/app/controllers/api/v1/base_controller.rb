module API::V1
  class BaseController < ::ApplicationController
    skip_before_filter  :verify_authenticity_token

    protected
    def ensure_valid_access_token!
      access_token || render_unauthorized
    end

    def access_token
      @access_token ||= AccessToken.from_request(request)
    end

    def current_user
      access_token.user if access_token
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Bearer realm="Application"'
      render json: { errors: 'Bad credentials' }, status: :unauthorized
    end
  end
end
