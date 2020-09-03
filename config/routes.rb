Rails.application.routes.draw do
  get 'welcome/index'

  #In Rails, a resourceful route provides a mapping between HTTP verbs
  # and URLs to controller actions. By convention, each action also maps to
  # a specific CRUD operation in a database.
  # creates seven different routes
  # resources :photos


  #The Rails.application.routes.draw do ... end block that wraps the route
  # definitions is required to establish the scope for the router DSL
  # and must not be deleted.
  resources :photos do
    delete :all_destroy, on: :collection
  end

  root 'welcome#index'
end
