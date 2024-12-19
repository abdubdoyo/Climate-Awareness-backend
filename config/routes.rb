Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  namespace :api do
        namespace :v1 do
          post 'chatbot/ask', to: 'chatbot#ask'
        end
  end
end
