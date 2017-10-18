Rails.application.routes.draw do
  devise_for :users

  scope '/tools' do
    scope '/admin' do
      resources :users, only: [:index]
      scope '/users' do
        get :search, controller: :users
        get :autocomplete, controller: :users
        # same => get "/search" => "users#search", as: :search
      end
    end
  end
  get "/" => redirect("/tools/admin/users")

end
