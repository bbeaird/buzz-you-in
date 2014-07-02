BuzzYouIn::Application.routes.draw do

  # get "users/add_phone_number"
  get 'static_pages/home'
  devise_for :users
  resources :visitor_passes, only: [:create, :index, :new, :destroy]
  resources :charges
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  root 'visitor_passes#index'

  get '/call-from-callbox', to: 'visitor_passes#call_from_callbox'
  get '/sms-from-visitor', to: 'visitor_passes#sms_from_visitor'

  post '/twilio/voice' => 'twilio#voice'
  get '/twilio/voice' => 'twilio#voice'

  get '/users/gather_phone_numbers', to: 'users#gather_phone_numbers'

  patch '/users/add_phone_numbers', to: 'users#add_phone_numbers'
  patch '/users/add_resident_byi_phone_number', to: 'users#add_resident_byi_phone_number'

  get '/users/search_for_twilio_number', to: 'users#search_for_twilio_number'
  post '/users/search_for_twilio_number', to: 'users#search_for_twilio_number'

  post '/search_for_twilio_numbers', to: 'users#search_for_twilio_numbers'

  get '/users/list_twilio_numbers', to: 'users#list_twilio_numbers'
  post '/users/list_twilio_numbers', to: 'users#list_twilio_numbers'

  post '/buy_twilio_number', to: 'users#buy_twilio_number'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
