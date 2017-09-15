Rails.application.routes.draw do
  root 'bank_accounts#index'
  devise_for :users
  resources :bank_accounts
end
