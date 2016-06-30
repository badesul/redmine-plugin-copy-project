 resources :copyproject do
    member do
      get 'index'
      match 'copy', :via => [:get, :post]
    end
end