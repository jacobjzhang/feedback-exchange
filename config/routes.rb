Rails.application.routes.draw do
  get '/score_card_example', to: 'score_cards#example'
  resources :projects
  resources :matches, :path => "review"
  resources :score_cards

  # get '/projects/:id/matches', to: 'projects#matches'
  # get '/projects/:project_id/new_match', to: 'matches#new'
  devise_for :users, controllers: {
    registrations: 'users_registrations'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'brochure#index'
end
