Rails.application.routes.draw do
  resources :customer_payments
  resources :rate_charts
  resources :daily_collections do
    collection do
      get 'payment_register'
      get 'daily_report'
    end
  end
  root 'dashboard#index'
  resources :customers

  get 'rate_by_snf_and_fat', to: 'rate_charts#rate_by_snf_and_fat'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
