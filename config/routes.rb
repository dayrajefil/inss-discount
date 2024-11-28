Rails.application.routes.draw do
  post 'proponents/inss_amount', to: 'proponents#inss_amount'
  resources :proponents, except: :show
end
