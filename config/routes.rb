Rails.application.routes.draw do
  root 'static#index'
  get '/auth/slack/callback' => 'session#slack_callback'

  resources :proxy_rules
end
