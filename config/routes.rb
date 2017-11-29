Rails.application.routes.draw do
  resource :webhook, only: [:create]
end