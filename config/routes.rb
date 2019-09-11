Rails.application.routes.draw do
  devise_for :users

  resources :jobs do
    get '/assignjob',to: "jobs#assignjob"
    patch '/assignjob',to: "jobs#sub"
    patch :assign_job_update
    patch :accept_job
    patch :reject_job
    patch :close_job
  end

  resources :users, only:[:index,:show,:feed]
  resources :request


  root 'jobs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
