Rails.application.routes.draw do
  get 'reports/proponent_salary', to: 'reports#proponent_salary', as: 'proponent_salary'
  post 'proponents/inss_amount', to: 'proponents#inss_amount'
  resources :proponents, except: :show
end
