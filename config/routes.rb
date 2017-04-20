Rails.application.routes.draw do
  resources :users do
    resources :buckets do
      resources :items
    end
  end
end
