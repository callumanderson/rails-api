Rails.application.routes.draw do
  # Namespace the api controllers without affecting the URL
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :todos do
      resources :items
    end
  end

  post '/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
