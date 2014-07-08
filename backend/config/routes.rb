Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :token, only: [:create]
    end
  end
end
