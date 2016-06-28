# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

  get 'copyproject', :to => 'copyproject#index'
  post 'copyproject', :to => 'copyproject#index'  

  resources :copyproject do
    member do
      match 'copy', :via => :post
    end
  end