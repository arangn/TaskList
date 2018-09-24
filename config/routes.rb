Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  patch '/tasks/:id/mark_complete', to: 'tasks#mark_complete', as: 'mark_complete'
 end
