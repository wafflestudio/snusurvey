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

  resources :surveys, :only => [:new, :create, :show, :update] do
    match "/question" => "surveys#question", :on => :member
  end

  resources :questions, :only => [:new] do
  end
end
