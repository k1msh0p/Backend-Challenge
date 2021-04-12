Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :members do
    get :define_friend, on: :member
    get :save_friend, on: :member
    get :search_expert, on: :member
    post :search_expert_result, on: :member
  end
  root 'members#index'

end
