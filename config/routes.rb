BossLady::Engine.routes.draw do
  root 'factories#index'

  resources :factories
end
