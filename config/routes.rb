SolidareIt::Application.routes.draw do

  scope "(:locale)", locale: /en|fr|nl/ do

    devise_for :users, :controllers => { :registrations => "registrations" }
    devise_scope :user do
      get "users/sign_up_with_organization", :to => "registrations#new_with_organization", :as => "new_user_with_organization_registration"
    end


    def base()
      get "pages/*id" => 'pages#show', :as => :page, :format => false
      resources :exchanges do
        get "author", :to => "exchanges#author"
        resources :proposals do
          get "author", :to => "proposals#author"
          resources :comments do
            get "author", :to => "comments#author"
          end
        end
      end
    end


    resources :organizations do
      base()
      resources :memberships
      resources :assistances, :path => "people_in_need"
      resources :people_in_need do
        base()
      end
    end
    resources :users
    base()
    root 'pages#show', id: 'home'
  end
  ActiveAdmin.routes(self)


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
