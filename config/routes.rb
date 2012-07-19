Spotxm::Application.routes.draw do
    root to: 'channels#index'
    resources :channels, only: [:show]    
end
