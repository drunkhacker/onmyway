Doorbell::Application.routes.draw do
  scope :api do
    post 'users' => 'users#create'

    get 'meetings' => 'meetings#pendings'
    get 'meetings/history' => 'meetings#history'
    post 'meetings' => 'meetings#create'
    get 'meetings/new' => 'meetings#new'

    post 'meetings/:id/confirm' => 'meetings#confirm'
    post 'meetings/:id/discard' => 'meetings#discard'

    # is this really needed?
    delete 'meetings/:id' => 'meetings#destroy'
    get 'leaderboard' => 'meetings#ranks'
    get ':salt' => 'meetings#show', constratins: {salt: /\d+\_\d+/}
  end

  #omniauth-facebook callback
  get 'auth/facebook/callback' => 'users#auth'
  get 'auth/failure' => 'users#auth_failure'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

end
