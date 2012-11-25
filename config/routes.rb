Snusurvey::Application.routes.draw do
  namespace :admin do
    match '/' => 'admin#index'
    match 'login' => 'auth#login'
    match 'logout' => 'auth#logout'
    match 'authorize' => 'auth#authorize'
    resources :boards
    resources :categories
    resources :examples
    resources :example_templates
    resources :feedbacks
    resources :papers
    resources :posts
    resources :questions
    resources :question_templates
    resources :replies
    resources :result_templates
    resources :surveys
    resources :survey_templates
    resources :users
  end

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
