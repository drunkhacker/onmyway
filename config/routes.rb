Doorbell::Application.routes.draw do
  post 'users' => 'users#create'

  get 'meetings' => 'meetings#index'
  get 'meetings/pending' => 'meetings#pendings'
  get 'meetings/history' => 'meetings#history'
  post 'meetings' => 'meetings#create'
  get 'meetings/new' => 'meetings#new'

  post 'meetings/:id/confirm' => 'meetings#confirm'
  post 'meetings/:id/discard' => 'meetings#discard'

  # is this really needed?
  delete 'meetings/:id' => 'meetings#destroy'

  #omniauth-facebook callback
  get 'auth/facebook/callback' => 'users#auth'
  get 'auth/failure' => 'users#auth_failure'

  get ':salt' => 'meetings#show', constratins: {salt: /\d+\_\d+\_\d+/}


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

end
