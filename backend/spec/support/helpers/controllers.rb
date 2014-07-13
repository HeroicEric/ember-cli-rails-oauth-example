module Helpers
  module Controllers
    def mock_access_token_for(user)
      request.env['HTTP_AUTHORIZATION'] = "Bearer #{user.access_token.access_token}"
    end

    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
