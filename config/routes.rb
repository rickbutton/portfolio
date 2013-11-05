Portfolio::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :items do
    member do
      get ':path/content' => 'items#content', :constraints => {:path => /.*/}, :as => :content
      get ':path' => 'items#path', :constraints => {:path => /.*/}, :as => :directory
    end
  end
  root "items#index"
end
