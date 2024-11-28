Rails.application.routes.draw do
  resources :proponents, except: :show
end
