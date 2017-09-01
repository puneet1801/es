Rails.application.routes.draw do
  resources :campaigns do
  	collection do
  		get :search
  	end
  end
  root :to => 'campaigns#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
