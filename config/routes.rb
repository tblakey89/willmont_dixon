WillmontDixon::Application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :pre_enrolment_tests do
      resources :sections do
        member do
          get 'questions'
          get 'videos'
          post 'check_answers'
        end
        collection do
          get 'all'
        end
      end
      resources :questions
      resources :videos do
        member do
          get :and_questions
        end
      end
      member do
        get 'begin_test'
      end
    end
    resources :users do
      resources :next_of_kins
      resources :employers
      member do
        get 'disciplinary_cards'
      end
      collection do
        post 'save_progress'
        post 'cscs_check'
        post 'find_by_auth_token'
        get 'submit_results'
      end
    end
    resources :admins
    resources :disciplinary_cards
    resources :passwords do
      collection do
        post "check_password"
      end
    end
  end

  namespace :admin do
    resources :pages do
      collection do
        get 'home'
      end
    end
  end

  resources :pages do
    collection do
      get 'home'
    end
  end

  match "/test" => "pages#home", via: :get
  match "/test/*path" => "pages#home", via: :get
  match "/admin/" => "admin/pages#home", via: :get
  match "/admin/*path" => "admin/pages#home", via: :get
  post "api/users/:id" => "api/users#update"
  root "pages#home"
  devise_for :user, path_prefix: 'api'
  devise_scope :user do
    post 'api/registrations' => 'api/registrations#create', as: 'register'
    post 'api/sessions' => 'api/sessions#create', as: 'login'
    delete 'api/sessions' => 'api/sessions#destroy', as: 'logout'
  end

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
