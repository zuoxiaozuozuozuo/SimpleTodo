Rails.application.routes.draw do

  resources :todos, except: [:show, :new]
  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'           # 获取登录表路由
  post '/login', to: 'sessions#create'       # 登录路由
  delete '/logout', to: 'sessions#destroy'   # 登出路由

end
