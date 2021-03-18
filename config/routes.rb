Rails.application.routes.draw do



  namespace :admin do
    get 'order_details/update'
  end
  devise_for :customers, controllers: {
   registrations: "customers/registrations",
   sessions: "customers/sessions"
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root to: 'homes#top'


  devise_for :admins, controllers: {
     registrations: "admins/registrations",
     sessions: "admins/sessions"
     }

   get "/about" => "homes#about"
   get "/customers/unsubscribe" => "customers#unsubscribe"
   patch "/customers/withdraw" => "customers#withdraw"
   delete "/cart_items/destroy_all" => "cart_items#destroy_all"
   post "/orders/confirm" => "orders#confirm"
   get "/orders/complete" => "orders#complete"

  # namespace :public do
   resources :addresses, except: [:show, :new]
   resources :items, only: [:index, :show]
   resources :customers, only: [:show, :edit, :update]
   resources :cart_items, only: [:index, :update, :destroy, :create]
   resources :orders, only: [:new, :create, :index, :show]
 # end

  get "/admin" => "admin/homes#top"
  get "/admin/sign_in" => "admins/sessions#new"
  post "/admin/sign_in" => "admins/sessions#create"
  delete "/admin/sign_out" => "admins/sessions#destroy"
  # patch "/admin/orders/:order_id/order_details/:id" => "admin/order_details#update"
#  "/admin/orders/#{@order.id}/order_details/#{@order_detail.id}"

  namespace :admin do
   resources :items, except: [:destroy]
   resources :genres, except: [:new, :show, :destroy]
   resources :customers, except: [:new, :create, :destroy]
   resources :orders, only: [:show, :update] do
    resources :order_details, only:[:update]
   end

 end
end