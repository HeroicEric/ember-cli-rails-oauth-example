module API::V1
  class BaseController < ::ApplicationController
    skip_before_filter  :verify_authenticity_token
  end
end
