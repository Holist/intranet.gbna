Rails.application.routes.draw do
  devise_for :users

  scope '/tools' do
    scope '/admin' do
      resources :users, only: [:index]
    end
  end

  get "/" => redirect("/tools/admin/users")

end
