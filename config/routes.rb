Rails.application.routes.draw do
  resources :currencies do
    collection { post :import }
  end

  root 'page#index'

end
