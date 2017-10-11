Rails.application.routes.draw do
  devise_for :users

  scope '/tools' do
    scope '/admin' do
      root to: 'pages#home'
    end
  end

end
