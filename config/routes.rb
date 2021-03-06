Si9n::Application.routes.draw do
  


  # Routes for Douban OAuth
  scope "/douban" do
    match '/new' => 'douban#new',           :as => :douban_login
    match '/callback' => 'douban#callback', :as => :douban_callback
    match '/logout' => 'douban#destroy',    :as => :douban_logout
  end

  root :to => "signatures#index"
  
  #评论
  resources :comments
  
  resources :signatures do
    collection do
      get :latest
      get :hottest
    end
    member do
      post :up
      post :syn
      post :delay_up
    end
  end

  scope "/mine" do
    match "/favorites"  => "mine#favorites",  :as => :my_favorites
    match "/signatures" => "mine#signatures", :as => :my_signatures
    match "/settings/edit" => "mine#edit_settings", :via => :put, :as => :edit_my_settings
  end
  
  namespace :admin do
    resources :signatures, :only => [:index] do
      member do
        post :hide
        post :display
      end
    end
  end
  

  # The priority is based upon order of creation: first created -> highest
  # priority.

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

  # You can have the root of your site routed with "root" just remember to
  # delete public/index.html. root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful
  # applications. Note: This route will make all actions in every controller
  # accessible via GET requests. match ':controller(/:action(/:id(.:format)))'
end
