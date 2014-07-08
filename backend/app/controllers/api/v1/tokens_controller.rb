module API::V1
  class TokensController < BaseController
    def create
      authenticate_user = AuthenticateUser.new(params[:code])
      authenticate_user.perform

      if authenticate_user.success?
        render json: authenticate_user.user.access_tokens.first_or_create
      else
        render json: { errors: authenticate_user.user.errors },
          status: :unprocessable_entity
      end
    end
  end
end
