WishableApi::Application.routes.draw do

  get "rails/g"

  get "rails/model"

  get "rails/WishVideo"

  resources :donations


  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions", :passwords => "users/passwords", :omniauth_callbacks => "users/omniauth_callbacks"}

  devise_scope :user do
    # User interactions
    post "/v1/users/register", :to => "users/registrations#create", :defaults => { :format => 'json' }, :as => 'user_sign_up'
    post "/v1/users/login", :to => "users/sessions#create", :defaults => { :format => 'json' }, :as => 'user_sign_in'
  end

  # Wishes
  post "/v1/wishes", :to => "wishes#create", :defaults => { :format => 'json' }, :as => 'create_a_wish'
  get "/v1/wishes", :to => "wishes#latest", :defaults => { :format => 'json' }, :as => 'latest_wishes'
  get "/v1/wishes/:id", :to => "wishes#show", :defaults => { :format => 'json' }, :as => 'show_wish'
  get "/v1/approve/:approval_key", :to => "wishes#approve", :defaults => { :format => 'json' }, :as => 'approve_wish'

  # Donations
  post "/v1/wishes/:id/donations", :to => "donations#create", :defaults => { :format => 'json' }, :as => 'add_a_donation'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  authenticated :user do
    #root :to => "apps#index"
  end
  root :to => 'high_voltage/pages#show', id: 'user_api'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
