Rails.application.routes.draw do
  # get '/score_card_example', to: 'score_cards#example'
  resources :projects do
    resources :score_cards
  end
  get '/review' => "matches#review"  
  get '/review/:page_id' => "matches#review"
  get '/matches' => "matches#index"
  get '/matches/page/:page' => "matches#paginate_mine"
  get '/score_cards/previous' => 'score_cards#show_previous'
  get '/score_cards/:id/upvote' => 'score_cards#upvote'
  get '/score_cards/:id/downvote' => 'score_cards#downvote'

  devise_for :users, controllers: {
    registrations: 'users_registrations'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'brochure#index'
end
