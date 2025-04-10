# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'reports/proponent_salary', to: 'reports#proponent_salary', as: 'proponent_salary'
  post 'proponents/inss_amount', to: 'proponents#inss_amount'
  resources :proponents, except: :show

  root 'proponents#index'
end
