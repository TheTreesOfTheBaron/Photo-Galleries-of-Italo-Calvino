Rails.application.routes.draw do
  devise_for :users

  get 'welcome/index'

  resources :photos do
    delete :destroy_multiple, on: :collection
    # delete :all_destroy, on: :collection
  end
  root 'welcome#index'
end
