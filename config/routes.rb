Spotxm::Application.routes.draw do
    resources :channels, only: [:find_channel]
    root to: 'channels#index'
    
end
