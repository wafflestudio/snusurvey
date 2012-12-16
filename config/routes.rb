Snusurvey::Application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  

# signin & signout
  match "/signin" => "sessions#new", :via => "get"
  match "/signin" => "sessions#create", :via => "post"
  match "/signin/facebook" => "sessions#facebook", :via => "post"
  match "/signin/facebook" => "sessions#oauth", :via => "get"
  match "/signout" => "sessions#destroy"

  # main controller
  root :to => "main#home"
  match "/about" => "main#about", :as => "about"
  match "/contact" => "main#contact", :as => "contact"
  match "/privacy" => "main#privacy", :as => "privacy"
  match "/help" => "main#help", :as => "help"
  match "/terms" => "main#terms", :as => "terms"

  resources :users, :only => [:new, :create]
  scope "/me" do
    get "/" => "users#me", :as => "me_users"
    get "/surveys" => "surveys#me", :as => "me_surveys"
    get "/papers" => "papers#me", :as => "me_papers"
  end

  resources :surveys, :only => [:new, :create, :show, :edit, :update, :destroy] do
    match "/enter" => "surveys#enter", :on => :member
    match "/result" => "surveys#result", :on => :member
  end

  resources :questions, :only => [:new, :destroy] do
  end

  resources :papers, :only => [:show, :destroy, :update] do
    match "/complete" => "papers#complete", :on => :member
    match "/result" => "papers#result", :on => :member
  end

  resources :examples, :only => [:new, :destroy] do
  end
end
