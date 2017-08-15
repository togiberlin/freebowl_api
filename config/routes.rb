Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :games do
        resources :players do
          resources :frames, param: :frame_number, only: [:create, :update]
        end
      end
    end
  end
end
