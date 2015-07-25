Rails.application.routes.draw do


  resources :user_ratings
  get 'user_rating/rating_for_user/:user_id',to:'user_ratings#rating_for_user'

  resources :bank_accounts

  # Bid controller routes
  get 'bid/project/:project/show/:bid', to:'bid#show'

  get 'bid/create'

  get 'bid/update'

  get 'bid/delete'

  get 'bid/granted'

  get 'bid/project/:project/bid/:bid/dashboard', to:'bid#bid_dashboard'

  post 'bid/grant'

  post 'bid/user_reaction'

  post 'bid/create'

  post 'bid/bid_completed'

  patch 'bid/update/:id',to:'bid#update'

  get 'bid/project/:project/bid/:bid/destroy_bid/', to:'bid#destroy_bid'

  get 'bid/project/:project/bid/:bid/lost_request', to:'bid#project_lost_request'

  patch  'bid/project_lost_request_post'

  get 'bid/:project/bid/:bid/lost_project_report/', to:'bid#lost_project_report'

  # Stop Bid controller route

  post 'milestone/milestone_progress'

  post 'milestone/milestone_complete'

  post 'milestone/milestone_payment'




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

  post 'projects/project_status'

  devise_for :users
             # :controllers => {:omniauth_callbacks => "omniauth_callbacks"}

  devise_for :admins, controllers: {sessions: 'admins/sessions',registrations:'admins/registrations',confirmations:'admins/confirmations'}

  get 'home/index'

  get 'home/about'

  get 'home/sign_in'

  get 'home/contact'

  post 'home/get_secret_key'


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

  get 'dashboard/project/:project/bid/:bid/payment', to:'dashboard#payment_details'

  get 'dashboard/pending_project'

  get 'dashboard/pending_projects'

  get 'dashboard/timeline'

  get 'dashboard/my_status'

  get 'dashboard/my_income'
  get 'transaction/add_money_new'
  post 'transaction/add_money'
  get 'transaction/add_money_receipt'


  get 'transaction/withdraw_money_new'
  post 'transaction/withdraw_money'
  get 'transaction/withdraw_receipt'


  get 'dashboard/projects_history'

  post 'dashboard/request_admin/:project', to:'dashboard#request_admin'

  # Admin Dashboard section

  get 'web/admin', to: 'admin_dashboard#index'
  get 'admin_dashboard/index'
  get 'admin_dashboard/projects'
  get 'admin_dashboard/project'
  get 'admin_dashboard/user_database'
  get 'admin_dashboard/notifications'
  get 'admin_dashboard/settings'
  get 'admin_notification/resolve_notification/:request/:project', to:'admin_notification#resolve_notification'
  post 'admin_notification/get_users'
  post 'admin_notification/recommend_users'
  post 'admin_settings/change_maintenance_mode'
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
