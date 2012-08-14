Snusurvey::Application.routes.draw do

# main controller
  root :to => "main#home"
  match "/about" => "main#about"
  match "/contact" => "main#contact"
  match "/privacy" => "main#privacy"
  match "/help" => "main#help"
  match "/terms" => "main#terms"

  resources :users, :only => [:new, :create]
  resources :feedbacks, :only => [:index, :create, :destroy]
end
