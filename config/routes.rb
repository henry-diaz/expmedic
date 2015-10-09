Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'panel/sessions', passwords: 'panel/passwords' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  namespace :panel do
    root 'dashboard#index'
    resources :clinics
    resources :admins
    resources :patients
    resources :histories
    resources :consultations
    resources :settings
    resources :reports
  end

end
