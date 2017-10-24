Rails.application.routes.draw do
  devise_for :users

  scope '/tools' do
    scope '/admin' do
      resources :users, only: [:index, :edit, :update]
      scope '/users' do
        post :sync, controller: :users, as: :users_sync
        get :search, controller: :users
        get :autocomplete, controller: :users
        # same => get "/search" => "users#search", as: :search
      end
    end
  end
  get "/" => redirect("/tools/admin/users")

end
