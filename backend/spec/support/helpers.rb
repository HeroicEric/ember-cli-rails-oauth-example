module Helpers
  module Controllers
    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
