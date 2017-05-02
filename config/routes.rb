Rails.application.routes.draw do
  # namespace the controllers without affecting the URI
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users do
      resources :buckets do
        resources :items
      end
    end
  end
  
  post 'auth/login', to: 'authentication#authenticate' 
end
