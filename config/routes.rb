Spotxm::Application.routes.draw do
    root to: 'channels#index'
    resources :channels, only: [:index, :show]    
    resources :tracks, only: :index
end
