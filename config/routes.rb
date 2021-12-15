Rails.application.routes.draw do

  get "cheeses", to: "cheeses#index"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
