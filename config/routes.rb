Rails.application.routes.draw do
  resources :users do
    resources :buckets do
      resources :items
    end
  end
  post 'auth/login', to: 'authentication#authenticate' 
end
