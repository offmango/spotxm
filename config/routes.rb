Spotxm::Application.routes.draw do
    root to: 'channels#index'
    resources :channels, only: [:index]    
end
