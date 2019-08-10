Rails.application.routes.draw do
  get '/score_card_example', to: 'score_cards#example'
  resources :projects do
    resources :matches
    resources :score_cards
  end
  # get '/projects/:id/matches', to: 'projects#matches'
  # get '/projects/:project_id/new_match', to: 'matches#new'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'brochure#index'
end
