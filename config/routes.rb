Rails.application.routes.draw do
  resources :ndl_books, :only => [:index, :create]
end
