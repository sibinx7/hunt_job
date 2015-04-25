Rails.application.routes.draw do

  resources :bank_accounts

  get 'bid/project/:project/show/:bid', to:'bid#show'

  get 'bid/create'

  get 'bid/update'

  get 'bid/delete'

  post 'bid/grant'

  post 'bid/user_reaction'

  get 'bid/project/:project/bid/:bid/dashboard', to:'bid#bid_dashboard'

  post 'milestone/milestone_progress'

  get 'bid/granted'

  get 'skills/index'

  post 'skills/create'

  get 'skills/store'

  get 'skills/edit'

  get 'skills/update'

  get 'skills/delete'

  get 'skills/json_view'

  # Add Extra information  for users table
  get 'user_extras/user_info'
  get 'user_extras/add_user_info'
  patch 'user_extras/save_user_info'
  get 'user_extras/add_user_image'
  patch 'user_extras/save_user_image'
  get 'user_extras/user_skill_info'
  resources :services

  mount Ckeditor::Engine => '/ckeditor'
  resources :projects

  devise_for :users
             # :controllers => {:omniauth_callbacks => "omniauth_callbacks"}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'

  get 'home/about'

  get 'home/sign_in'

  get 'home/contact'

  get 'home/maintenance'

  get 'dashboard/index'

  get 'dashboard/users'

  get 'dashboard/user'

  get 'dashboard/projects'

  get 'dashboard/project/:project', to: 'dashboard#project'

  get 'dashboard/user/:user', to: 'dashboard#user_profile'

  get 'dashboard/settings'

  get 'dashboard/bid/:project', to:'dashboard#bid'

  get 'dashboard/project/:project/bid/:bid', to:'dashboard#edit_bid'

  get 'dashboard/payments'

  get 'dashboard/pending_project'

  get 'dashboard/pending_projects'

  post 'bid/create'
  patch 'bid/update/:id',to:'bid#update'
  delete 'bid/project/:project/bid/:bid/destroy/', to:'bid#destroy'
  # Edit users info


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

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

  # Mount CKEditor
  # mount Ckeditor::Engine => '/ckeditor'
end
