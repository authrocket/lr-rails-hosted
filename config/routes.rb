Rails.application.routes.draw do

  get 'restricted' => 'home#restricted'

  get 'login' => 'logins#login'
  get 'logout' => 'logins#logout'
  get 'signup' => 'signups#create'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
