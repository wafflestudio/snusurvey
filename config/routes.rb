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
  match "/about" => "main#about"
  match "/contact" => "main#contact"
  match "/privacy" => "main#privacy"
  match "/help" => "main#help"
  match "/terms" => "main#terms"

  resources :users, :only => [:new, :create]
  namespace :me do
    match "/" => "users#me"
    match "/surveys" => "surveys#me"
    match "/papers" => "papers#me"
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
